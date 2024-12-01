import os
import math
import strconv

fn p1(input string) !int {
	lines := os.read_lines(input)!

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
		sum += math.abs(l[i] - r[i])
	}

	return sum
}

fn p2(input string) !int {
	lines := os.read_lines(input)!

	mut sim := map[int]int{}
	mut l := []int{}

	for line in lines {
		words := line.split('   ')
		l << strconv.atoi(words[0])!
		sim[strconv.atoi(words[1])!] += 1
	}

	mut rat := 0

	for ll in l {
		rat += sim[ll] * ll
	}

	return rat
}

fn main() {
	input := 'input'

	println('Sum: ${p1(input)!}')
	println('Rating: ${p2(input)!}')
}
