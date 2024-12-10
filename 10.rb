#!/usr/bin/env ruby

def path(x, y, lines, ends)
  return 0 if x < 0 || x >= lines.length || y < 0 || y >= lines[0].length

  curr = lines[x][y].to_i
  if curr == 9 then
    if ends["#{x},#{y}"] == false then
      ends["#{x},#{y}"] = true
    end
    return
  end

  dirs = [[0, -1], [1, 0], [0, 1], [-1, 0]]

  dirs.each do |dir|
    xx = x + dir[0]
    yy = y + dir[1]

    if xx >= 0 && xx < lines.length && yy >= 0 && yy < lines[0].length then 
      if lines[xx][yy].to_i == curr + 1 then
        path(xx, yy, lines, ends)
      end
    end
  end
end

def p1
  # Read file
  file = File.new("input", "r")
  lines = file.readlines.map(&:chomp)
  file.close()

  # Find all ends
  ends = {}

  lines.each_with_index do |line, i|
    line.chars().each_with_index do |char, j|
      ends["#{i},#{j}"] = false
    end
  end

  # Count paths
  paths = 0

  lines.each_with_index do |line, i|
    line.chars().each_with_index do |char, j|
      if char == '0' then
        path(i, j, lines, ends)

        ends.each do |k, v|
          paths += 1 if v == true
          ends[k] = false
        end
      end
    end
  end

  puts paths   
end

def rate(x, y, lines)
  return 0 if x < 0 || x >= lines.length || y < 0 || y >= lines[0].length

  curr = lines[x][y].to_i
  return 1 if curr == 9

  dirs = [[0, -1], [1, 0], [0, 1], [-1, 0]]
  paths = 0

  dirs.each do |dir|
    xx = x + dir[0]
    yy = y + dir[1]

    if xx >= 0 && xx < lines.length && yy >= 0 && yy < lines[0].length then 
      if lines[xx][yy].to_i == curr + 1 then
        paths += rate(xx, yy, lines)
      end
    end
  end

  return paths
end

def p2
  # Read file
  file = File.new("input", "r")
  lines = file.readlines.map(&:chomp)
  file.close()

  # Count paths
  paths = 0

  lines.each_with_index do |line, i|
    line.chars().each_with_index do |char, j|
      if char == '0' then
        paths += rate(i, j, lines)
      end
    end
  end

  puts paths
end

if __FILE__ == $0 then
  p1()
  p2()
end
