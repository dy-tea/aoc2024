import os
import math
import strconv

fn diff(a int, b int) int {
	return math.abs(a - b)
}

fn main() {
	file := os.read_file('input')!
	lines := file.split_into_lines()

  // Part 1

	mut l := []int{}
	mut r := []int{}

	for line in lines {
		words := line.split('   ')
		l << strconv.atoi(words[0])!
		r << strconv.atoi(words[1])!
	}

	l.sort()
	r.sort()

	mut sum := 0

	for i in 0 .. l.len {
		sum += diff(l[i], r[i])
	}

	println('Sum: ${sum}')

  // Part 2

	mut sim := [99999]int{ init: 0 }

	for ll in l {
		for rr in r {
			if ll == rr {
				sim[ll] += 1
			}
		}
	}

	mut rat := 0

	for i, n in sim {
		rat += i * n
	}

	println('Rating: ${rat}')
}
