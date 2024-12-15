#include <fstream>
#include <iostream>
#include <vector>

int box_count(std::vector<std::string>& grid) {
  int count = 0;
  for (int i = 0; i != grid.size(); ++i)
    for (int j = 0; j != grid[i].size(); ++j)
      if (grid[i][j] == 'O')
        count++;
  return count;
}

void print_grid(std::vector<std::string>& grid) {
  for (int i = 0; i != grid.size(); ++i)
    std::cout << grid[i] << std::endl;
}

void p1() {
  // Read file
  std::ifstream f("input");
  if (!f.is_open()) {
    std::cerr << "No input file found" << std::endl;
    return;
  }

  // Create grid and moves list from file
  std::string line;
  std::vector < std::string > grid;
  std::string moves = "";

  bool before = true;
  while (getline(f, line)) {
    if (line == "")
      before = false;

    if (before)
      grid.push_back(line);
    else
      moves += line;
  }

  // Find bot location
  int x, y;
  for (int i = 0; i != grid.size(); ++i)
    for (int j = 0; j != grid[i].size(); ++j)
      if (grid[i][j] == '@') {
        x = i;
        y = j;
        break;
      }

  // Perform moves
  for (char c: moves) {
    int dx = 0, dy = 0;

    switch (c) {
    case '<':
      dy = -1;
      break;
    case '>':
      dy = 1;
      break;
    case '^':
      dx = -1;
      break;
    case 'v':
      dx = 1;
      break;
    default:
      break;
    }

    int cx = x + dx;
    int cy = y + dy;

    // Check in range
    if (cx > 0 && cx < grid.size() && cy > 0 && cy < grid[cx].size()) {
      if (grid[cx][cy] == '.') {
        grid[x][y] = '.';
        x = cx;
        y = cy;
        grid[x][y] = '@';
      } else if (grid[cx][cy] == 'O') {
        std::vector < std::pair <int, int>> boxes;
        int check_x = cx;
        int check_y = cy;

        while (check_x > 0 && check_x < grid.size() && check_y > 0 &&
          check_y < grid[check_x].size() &&
          grid[check_x][check_y] == 'O') {
          boxes.push_back({
            check_x,
            check_y
          });
          check_x += dx;
          check_y += dy;
        }

        if (check_x > 0 && check_x < grid.size() && check_y > 0 &&
          check_y < grid[check_x].size() && grid[check_x][check_y] == '.') {

          for (int i = boxes.size() - 1; i >= 0; i--) {
            int from_x = boxes[i].first;
            int from_y = boxes[i].second;
            int to_x = from_x + dx;
            int to_y = from_y + dy;

            grid[from_x][from_y] = '.';
            grid[to_x][to_y] = 'O';
          }

          // Move player
          grid[x][y] = '.';
          x = cx;
          y = cy;
          grid[x][y] = '@';
        }
      }
    }
  }

  // Calculate sum
  int sum = 0;
  for (int i = 0; i != grid.size(); ++i)
    for (int j = 0; j != grid[i].size(); ++j)
      if (grid[i][j] == 'O')
        sum += i * 100 + j;

  print_grid(grid);
  std::cout << sum << std::endl;
}

int main() {
    p1();

    return 0;
}
