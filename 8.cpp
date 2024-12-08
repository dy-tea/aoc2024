#include <iostream>
#include <fstream>
#include <vector>
#include <unordered_map>
#include <unordered_set>

struct pair_hash {
  template <class T1, class T2>
  std::size_t operator() (const std::pair<T1, T2>& pair) const {
    return std::hash<T1>()(pair.first) ^ std::hash<T2>()(pair.second);
  }
};

void p1() {
  // Read file into map
  std::ifstream file("input");

  std::unordered_map<char, std::vector<std::pair<int, int>>> vertices;
  std::vector<std::string> lines;

  std::string line;
  int line_count = 0;

  while (getline(file, line)) {
    lines.push_back(line);

    for (size_t i = 0; i != line.size(); ++i)
      if (line[i] != '.')
        vertices[line[i]].emplace_back(std::pair(i, line_count));

    line_count++;
  }
  file.close();

  // Count 
  std::unordered_set<std::pair<int, int>, pair_hash> antinodes;

  for (const auto& vertex : vertices) {
    const auto& positions = vertex.second;

    for (size_t i = 0; i != positions.size(); ++i) {
      for (size_t j = i + 1; j != positions.size(); ++j) {
        int x1 = positions[i].first;
        int x2 = positions[j].first;

        int y1 = positions[i].second;
        int y2 = positions[j].second;

        int dx = x2 - x1;
        int dy = y2 - y1;

        int px = x2 + 2 * dx;
        int py = y2 + 2 * dy;
        
        if (px >= 0 && py >= 0)
          antinodes.emplace(px, py);

        int mx = x1 - 2 * dx;
        int my = y1 - 2 * dy;

        if (mx >= 0 && my >= 0)
          antinodes.emplace(mx, my);
      }
    }
  }

  std::cout << antinodes.size() << std::endl;
}

void p2() {
  // Read file into map
  std::ifstream file("input");

  std::unordered_map<char, std::vector<std::pair<int, int>>> vertices;
  std::vector<std::string> lines;

  std::string line;
  int line_count = 0;
  int line_size = 0;

  while (getline(file, line)) {
    line_size = line.size() > 0 ? line.size() : line_size;
    lines.push_back(line);

    for (size_t i = 0; i != line.size(); ++i)
      if (line[i] != '.')
        vertices[line[i]].emplace_back(std::pair(i, line_count));

    line_count++;
  }
  file.close();

  // Count
  std::unordered_set<std::pair<int, int>, pair_hash> antinodes;

  for (const auto& vertex : vertices) {
    const auto& positions = vertex.second;

    for (size_t i = 0; i != positions.size(); ++i) {
      for (size_t j = i + 1; j != positions.size(); ++j) {
        int x1 = positions[i].first;
        int x2 = positions[j].first;

        int y1 = positions[i].second;
        int y2 = positions[j].second;

        int dx = x2 - x1;
        int dy = y2 - y1;

        for (int k = 0;; ++k) {
          int px = x2 + k * dx;
          int py = y2 + k * dy;

          if (px >= line_size || py >= line_count || px < 0 || py < 0) break;

          antinodes.emplace(px, py);
        }

        for (int k = 0;; ++k) {
          int mx = x1 - k * dx;
          int my = y1 - k * dy;

          if (mx >= line_size || my >= line_count || mx < 0 || my < 0) break;
          
          antinodes.emplace(mx, my);
        }
      }
    }

    int x1 = positions[positions.size() - 1].first;
    int x2 = positions[0].first;

    int y1 = positions[positions.size() - 1].second;
    int y2 = positions[0].second;

    int dx = x2 - x1;
    int dy = y2 - y1;

    for (int k = 0;; ++k) {
      int px = x2 + k * dx;
      int py = y2 + k * dy;

      if (px >= line_size || py >= line_count || px < 0 || py < 0) break;

      antinodes.emplace(px, py);
    }

    for (int k = 0;; ++k) {
      int mx = x1 - k * dx;
      int my = y1 - k * dy;

       if (mx >= line_size || my >= line_count || mx < 0 || my < 0) break;

      antinodes.emplace(mx, my);
    }
  }

  std::cout << antinodes.size() << std::endl;
}

int main() {
  p1();
  p2();

  return 0;
}
