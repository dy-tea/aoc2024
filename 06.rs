use std::fs::File;
use std::io::{BufReader, BufRead};
use std::path::Path;

fn read_file<P>(filename: P) -> Result<Vec<Vec<char>>, std::io::Error> 
where 
    P: AsRef<Path> 
{
    let file = File::open(filename)?;
    let reader = BufReader::new(file);
    let mut lines = Vec::new();

    for line in reader.lines() {
        lines.push(line?.chars().collect::<Vec<char>>());
    }

    Ok(lines)
}

fn p1() {
    let filename = "input";
    let mut lines = read_file(filename).expect("Failed to read file");

    let mut x = 0;
    let mut y = 0;

    for (j, line) in lines.iter().enumerate() {
        for (i, c) in line.iter().enumerate() {
            if *c == '^' {
                x = i;
                y = j;
                break;
            }
        }
    }

    let mut sum = 1;
    lines[y][x] = 'X';

    let dirs = [(0, -1), (1, 0), (0, 1), (-1, 0)];
    let mut curr_dir = 0;

    loop {
        let (dx, dy) = dirs[curr_dir];

        let next_x = (x as isize) + dx;
        let next_y = (y as isize) + dy;

        if next_x >= 0 && next_y >= 0 && next_x < lines[0].len() as isize && next_y < lines.len() as isize {
            match lines[next_y as usize][next_x as usize] {
                '#' => {
                    curr_dir = (curr_dir + 1) % 4;
                }
                '.' | '^' => {
                    sum += 1; 

                    lines[next_y as usize][next_x as usize] = 'X';

                    x = next_x as usize;
                    y = next_y as usize;
                }
                _ => {
                    x = next_x as usize;
                    y = next_y as usize;
                }
            }
        } else {
            break;
        }
    }

    println!("{}", sum);
}

fn p2() {
    let filename = "input";
    let lines = read_file(filename).expect("Failed to read file");

    let guard_pos = {
        let mut x = 0;
        let mut y = 0;
        for (j, line) in lines.iter().enumerate() {
            for (i, c) in line.iter().enumerate() {
                if *c == '^' {
                    x = i;
                    y = j;
                    break;
                }
            }
        }
        (x, y)
    };

    let mut sum = 0;

    for i in 0..lines.len() {
        for j in 0..lines[i].len() {
            if lines[i][j] == '.' {
                println!("{}, {}", i, j);

                let mut grid = lines.clone();
                grid[i][j] = '#';

                if loops(&grid, guard_pos) {
                    sum += 1;
                }
            }
        }
    }
    
    println!("{}", sum);
}

fn loops(lines: &Vec<Vec<char>>, guard_pos: (usize, usize)) -> bool {
    let (mut x, mut y) = guard_pos;

    let dirs = [(0, -1), (1, 0), (0, 1), (-1, 0)];
    let mut dir = 0;

    const MAX_TURNS: usize = 1000;
    let mut turns = 0;

    loop {
        let (dx, dy) = dirs[dir];

        if turns == MAX_TURNS {
            return true;
        }

        let next_x = (x as isize) + dx;
        let next_y = (y as isize) + dy;

        if next_x >= 0 && next_y >= 0 && next_x < lines[0].len() as isize && next_y < lines.len() as isize {
            match lines[next_y as usize][next_x as usize] {
                '#' => {
                    dir = (dir + 1) % 4;
                    turns += 1;
                }
                _ => {
                    x = next_x as usize;
                    y = next_y as usize;
                }
            }
        } else {
            return false;
        }
    }
}

fn main() {
    p1();
    p2();
}

