import os
import math
import strconv

fn find(lines []string, target rune) !(int, int) {
	for i, line in lines {
		for j, c in line {
			if c == target {
				return i, j
			}
		}
	}

	return error('not found')
}

fn solve_maze(grid []string, sx int, sy int, ex int, ey int) int {
	dirs := [[1, 0], [0, -1], [-1, 0], [0, 1]]
	mut queue := [][]int{}
	mut visited := map[string]int{}
	mut min := u64(99999999999)

	queue << [sx, sy, 3, 0]
	visited['${sx},${sy}'] = 0

	for queue.len > 0 {
		curr := queue[0]

		cx := curr[0]
		cy := curr[1]
		dir := curr[2]
		cost := curr[3]

		queue.delete(0)

		if cx == ex && cy == ey {
			min = math.min(min, u64(cost))
			continue
		}

		for i in 0 .. 4 {
			nx, ny := cx + dirs[i][0], cy + dirs[i][1]
			if nx >= 0 && ny >= 0 && ny < grid.len && nx < grid[0].len && grid[nx][ny] != `#` {
				mut nc := cost + if dir == i { 1 } else { 1001 }

				key := '${nx},${ny}'
				if key !in visited || visited[key] > nc {
					visited[key] = nc
					queue << [nx, ny, i, nc]
				}
			}
		}
	}

	return int(min)
}

fn tile_count(grid []string, sx int, sy int, ex int, ey int) int {
	dirs := [[1, 0], [0, -1], [-1, 0], [0, 1]]
	mut queue := [][]int{}
	mut valid_tiles := map[string]bool{}
	mut dist_to := map[string]int{}
	mut dist_from := map[string]int{}

	min_cost := solve_maze(grid, sx, sy, ex, ey)

	queue << [sx, sy, 3, 0]
	dist_to['${sx},${sy}'] = 0

	for queue.len > 0 {
		curr := queue[0]
		queue.delete(0)

		cx := curr[0]
		cy := curr[1]
		dir := curr[2]
		cost := curr[3]

		if cost > min_cost {
			continue
		}

		for i in 0 .. 4 {
			nx := cx + dirs[i][0]
			ny := cy + dirs[i][1]
			if nx >= 0 && ny >= 0 && ny < grid.len && nx < grid[0].len && grid[nx][ny] != `#` {
				mut nc := cost + if dir == i { 1 } else { 1001 }

				key := '${nx},${ny}'

				if nc <= min_cost {
					if key !in dist_to || dist_to[key] > nc {
						dist_to[key] = nc
						queue << [nx, ny, i, nc]
					}
				}
			}
		}
	}

	queue.clear()
	queue << [ex, ey, 3, 0]
	dist_from['${ex},${ey}'] = 0

	for queue.len > 0 {
		curr := queue[0]
		queue.delete(0)

		cx := curr[0]
		cy := curr[1]
		dir := curr[2]
		cost := curr[3]

		if cost > min_cost {
			continue
		}

		for i in 0 .. 4 {
			nx := cx + dirs[i][0]
			ny := cy + dirs[i][1]
			if nx >= 0 && ny >= 0 && ny < grid.len && nx < grid[0].len && grid[nx][ny] != `#` {
				mut nc := cost + if dir == i { 1 } else { 1001 }
				key := '${nx},${ny}'

				if nc <= min_cost {
					if key !in dist_from || dist_from[key] > nc {
						dist_from[key] = nc
						queue << [nx, ny, i, nc]
					}
				}
			}
		}
	}

	for i in 0 .. grid.len {
		for j in 0 .. grid[0].len {
			key := '${i},${j}'
			if key in dist_to && key in dist_from {
				if dist_to[key] + dist_from[key] == min_cost {
					valid_tiles[key] = true
				}
			}
		}
	}

	for key1, _ in valid_tiles {
		for key2, _ in valid_tiles {
			a := key1.split(',')
			x1 := strconv.atoi(a[0]) or { panic(err) }
			y1 := strconv.atoi(a[1]) or { panic(err) }
			b := key2.split(',')
			x2 := strconv.atoi(b[0]) or { panic(err) }
			y2 := strconv.atoi(b[1]) or { panic(err) }
			if x1 == x2 {
				mut valid := true
				for i in math.min(y1, y2) .. math.max(y1, y2) {
					if grid[x1][i] == `#` {
						valid = false
						break
					}
				}
				if valid {
					for i in math.min(y1, y2) .. math.max(y1, y2) {
						valid_tiles['${x1},${i}'] = true
					}
				}
			} else if y1 == y2 {
				mut valid := true
				for i in math.min(x1, x2) .. math.max(x1, x2) {
					if grid[i][y1] == `#` {
						valid = false
						break
					}
				}
				if valid {
					for i in math.min(x1, x2) .. math.max(x1, x2) {
						valid_tiles['${i},${y1}'] = true
					}
				}
			}
		}
	}

	// Debug print
	for i in 0 .. grid.len {
		for j in 0 .. grid[0].len {
			key := '${i},${j}'
			if grid[i][j] == `#` {
				//print('#')
				print(' ')
			} else if key in valid_tiles {
				print('O')
			} else {
			   print(' ')
				//print('.')
			}
		}
		println('')
	}

	return valid_tiles.len
}

fn p1(input string) ! {
	lines := os.read_lines(input)!

	sx, sy := find(lines, `S`)!
	ex, ey := find(lines, `E`)!

	println(solve_maze(lines, sx, sy, ex, ey))
}

fn p2(input string) ! {
	lines := os.read_lines(input)!

	sx, sy := find(lines, `S`)!
	ex, ey := find(lines, `E`)!

	println(tile_count(lines, sx, sy, ex, ey))
}

fn main() {
	p1('input')!
	p2('input')!
}
