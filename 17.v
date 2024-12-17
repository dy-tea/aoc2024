import os
import math
import strconv

struct Cpu {
  mut:
    // Program
    program []u8

    // Registers
    pc int

    a i64
    b i64
    c i64
}

fn read_in_cpu(lines []string) !Cpu {
  mut a := 0
  mut b := 0
  mut c := 0

  mut p := []u8{}

  for i, line in lines {
    match i {
      0 {
        a = strconv.atoi(line.after(': '))!
      }
      1 {
        b = strconv.atoi(line.after(': '))!
      }
      2 {
        c = strconv.atoi(line.after(': '))!
      }
      4 {
        items := line.after(': ').split(',')
        for item in items {
          p << u8(strconv.atoi(item)!)
        }
      }
      else {}
    }
  }

  return Cpu {
    program: p
    pc: 0
    a: a
    b: b
    c: c
  }
}

fn (mut cpu Cpu) run() string {
  mut output := []string{}

  for cpu.pc < cpu.program.len {
    opcode := cpu.program[cpu.pc]
    operand := cpu.program[cpu.pc + 1]

    combo := match operand {
      0, 1, 2, 3 {
        operand
      }
      4 {
        cpu.a
      }
      5 {
        cpu.b
      }
      6 {
        cpu.c
      }
      else {
        // Invalid operand
        7
      }
    }

    match opcode {
      // adv
      0 {
        cpu.a /= math.powi(2, combo)
      }

      // bxl
      1 {
        cpu.b ^= operand
      }

      // bst
      2 {
        cpu.b = combo % 8
      }

      // jnz
      3 {
        if cpu.a != 0 {
          cpu.pc = operand
          continue
        }
      }

      // bxc
      4 {
        cpu.b ^= cpu.c
      }

      // out
      5 {
        output << (combo % 8).str()
      }

      // bdv
      6 {
        cpu.b = cpu.a / math.powi(2, combo)
      }

      // cdv
      7 {
        cpu.c = cpu.a / math.powi(2, combo)
      }

      else {
        eprintln('WARNING: Invalid opcode ${opcode} received')
      }
    }

    cpu.pc += 2
  }

  return output.join(",")
}

fn compute_i(lines []string, i u64) {
  mut cpu := read_in_cpu(lines) or { panic(err) }
  cpu.a = i;

  mut before := []string{}
  for dig in cpu.program {
    before << dig.str()
  }

  res := cpu.run()

  if before.join(',') == res {
    println('! ${i}')
  }
}

fn p1(input string) ! {
  lines := os.read_lines(input)!

  mut cpu := read_in_cpu(lines)!

  println(cpu.run())
}

fn p2(input string) ! {
  lines := os.read_lines(input)!

  mut cpu := read_in_cpu(lines)!
  cpu.a = 0

  mut threads := []thread{}

  for i in u64(10000000000000000) .. u64(100000000000000000) {
    threads << spawn compute_i(lines, i)

    if i % 1200 == 0 {
      threads.wait()
      threads.clear()
      println(i)
    }
  }

  println(cpu.a)
}

fn main() {
  p1('input')!
  p2('input2')!
}
