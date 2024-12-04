package main

import (
  "bufio"
  "fmt"
  "os"
)

func check1(lines []string, x int, y int) int {
	const word = "XMAS"
	sum := 0

	directions := [][2]int{
		{ 0,  1}, // x+
		{ 0, -1}, // x-
		{ 1,  0}, // y+
		{-1,  0}, // y-
		{ 1,  1}, // x+y+
		{-1, -1}, // x-y-
		{ 1, -1}, // x+y-
		{-1,  1}, // x-y+
	}

	for _, dir := range directions {
		dx, dy := dir[0], dir[1]
		check := ""

		for i := 0; i < 4; i++ {
			xx := x + i*dx
			yy := y + i*dy

			if xx < 0 || xx >= len(lines) || yy < 0 || yy >= len(lines[xx]) {
				break
			}

			check += string(lines[xx][yy])
		}

		if check == word {
			sum++
		}
	}

	return sum
}

func p1() {
  file := "input"
  read, err := os.Open(file)
  if err != nil {
    panic(err)
  }
  defer read.Close()

  scanner := bufio.NewScanner(read)
  scanner.Split(bufio.ScanLines)

  lines := []string{}

  for scanner.Scan() {
    lines = append(lines, scanner.Text())
  }

  sum := 0

  for i, line := range lines {
    for j, char := range line {
      if char == 'X' {
        sum += check1(lines, i, j)
      } 
    }
  }

  fmt.Println(sum)
}

func check2(lines []string, x int, y int) bool {
  sum := 0  

  if x >= 1 && y >= 1 && x < len(lines) - 1 && y < len(lines[x]) - 1 {
    if lines[x - 1][y - 1] == 'M' && lines[x + 1][y + 1] == 'S' {
      sum++
    }
    if lines[x - 1][y - 1] == 'S' && lines[x + 1][y + 1] == 'M' {
      sum++
    }
    if lines[x - 1][y + 1] == 'M' && lines[x + 1][y - 1] == 'S' {
      sum++
    }
    if lines[x - 1][y + 1] == 'S' && lines[x + 1][y - 1] == 'M' {
      sum++
    }
  }

  return sum == 2
}

func p2() {
  file := "input"
  read, err := os.Open(file)
  if err != nil {
    panic(err)
  }
  defer read.Close()

  scanner := bufio.NewScanner(read)
  scanner.Split(bufio.ScanLines)

  lines := []string{}

  for scanner.Scan() {
    lines = append(lines, scanner.Text())
  }

  sum := 0

  for i, line := range lines {
    for j, char := range line {
      if char == 'A' {
        if check2(lines, i, j) {
          sum++
        }
      } 
    }
  }

  fmt.Println(sum)
}

func main() {
  p1() 
  p2()
}
