using System;
using System.Collections.Generic;
using System.IO;

namespace Day5 {
  class Program {
    static void Main(string[] args) {
      p1();
      p2();
    }

    static void p1() {
      var reader = File.OpenText("input");

      int sum = 0;
      bool mapping = true;
      Dictionary<int, List<int>> map = new Dictionary<int, List<int>>();

      while (!reader.EndOfStream) {
        var line = reader.ReadLine();

        if (line == "") {
          mapping = false;
        } else {
          if (mapping) {
            string[] nums = line.Split("|");

            int key = int.Parse(nums[0]);
            int val = int.Parse(nums[1]);

            if (!map.ContainsKey(key)) {
              map[key] = new List<int>();
            }

            map[key].Add(val);
          } else {
            string[] words = line.Split(",");
            
            List<int> nums = new List<int>();

            foreach (string word in words) {
              nums.Add(int.Parse(word));
            }

            if (valid(map, nums))  {
              sum += nums[nums.Count / 2];
            }
          }
        }
      }

      Console.WriteLine(sum);
    } 

    static void p2() {
      var reader = File.OpenText("input");

      int sum = 0;
      bool mapping = true;
      Dictionary<int, List<int>> map = new Dictionary<int, List<int>>();

      while (!reader.EndOfStream) {
        var line = reader.ReadLine();

        if (line == "") {
          mapping = false;
        } else {
          if (mapping) {
            string[] nums = line.Split("|");

            int key = int.Parse(nums[0]);
            int val = int.Parse(nums[1]);

            if (!map.ContainsKey(key)) {
              map[key] = new List<int>();
            }

            map[key].Add(val);
          } else {
            string[] words = line.Split(",");
            
            List<int> nums = new List<int>();

            foreach (string word in words) {
              nums.Add(int.Parse(word));
            }

            if (!valid(map, nums))  {
              nums = correct(map, nums);

              sum += nums[nums.Count / 2];
            }
          }
        }
      }

      Console.WriteLine(sum);
    }

    static bool valid(Dictionary<int, List<int>> map, List<int> pages) {
      Dictionary<int, int> position = new Dictionary<int, int>();

      for (int i = 0; i != pages.Count; ++i) {
        position[pages[i]] = i;
      }

      foreach (var kvp in map) {
        int key = kvp.Key;
        foreach (int val in kvp.Value) {
          if (position.ContainsKey(key) && position.ContainsKey(val)) {
            if (position[key] > position[val]) {
              return false;
            }
          }
        }
      }

      return true;
    }

    static List<int> correct(Dictionary<int, List<int>> map, List<int> pages) {
      Dictionary<int, List<int>> graph = new Dictionary<int, List<int>>();
      Dictionary<int, int> inDegree = new Dictionary<int, int>();

      foreach (var page in pages) {
        graph[page] = new List<int>();
        inDegree[page] = 0;
      }

      foreach (var kvp in map) {
        int key = kvp.Key;
        foreach (int val in kvp.Value) {
          if (pages.Contains(key) && pages.Contains(val)) {
            graph[key].Add(val);
            inDegree[val]++;
          }
        }
      }

      List<int> queue = new List<int>();
      foreach (var page in pages) {
        if (inDegree[page] == 0) {
          queue.Add(page);
        }
      }

      List<int> sortedPages = new List<int>();
      while (queue.Count > 0) {
        int current = queue[0];
        queue.RemoveAt(0);
        sortedPages.Add(current);

        foreach (var neighbor in graph[current]) {
          inDegree[neighbor]--;
          if (inDegree[neighbor] == 0) {
            queue.Add(neighbor);
          }
        }
      }

      return sortedPages;
    }
  }
}
