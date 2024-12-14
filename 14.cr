WIDTH = 101
HEIGHT = 103

def p1
  content = File.read("input")
  lines = content.split('\n')

  # tl, tr, bl, br
  quads = [0, 0, 0, 0] of Int32

  lines.each do |line|
    if m = line.match(/p=(\d+),(\d+) v=(-?\d+),(-?\d+)/)
      px = m[1].to_i32
      py = m[2].to_i32
      vx = m[3].to_i32
      vy = m[4].to_i32

      iters = 0
      while iters < 100
        iters += 1

        px += vx
        py += vy

        while px >= WIDTH
          px -= WIDTH 
        end
        while py >= HEIGHT
          py -= HEIGHT
        end

        while px < 0
          px += WIDTH
        end
        while py < 0
          py += HEIGHT
        end
      end

      if px < WIDTH // 2
        if py < HEIGHT // 2 
          quads[0] += 1 
        elsif py > HEIGHT // 2
          quads[2] += 1 
        end
      elsif px > WIDTH // 2
        if py < HEIGHT // 2
          quads[1] += 1 
        elsif py > HEIGHT // 2
          quads[3] += 1 
        end
      end
    end
  end

  sum = quads[0] * quads[1] * quads[2] * quads[3]

  puts sum
end

def p2
  content = File.read("input")
  lines = content.split('\n')

  bots = Deque(Array(Int32)).new

  lines.each do |line|
    if m = line.match(/p=(\d+),(\d+) v=(-?\d+),(-?\d+)/)
      px = m[1].to_i32
      py = m[2].to_i32
      vx = m[3].to_i32
      vy = m[4].to_i32

      bots.push([px, py, vx, vy])
    end
  end

  count = 0
  while count < 1000000
    count += 1

    botset = Set(Int32).new
    
    bots.each do |bot|
      bot[0] += bot[2]
      bot[1] += bot[3]

      while bot[0] < 0
        bot[0] += WIDTH
      end
      while bot[1] < 0
        bot[1] += HEIGHT
      end

      while bot[0] >= WIDTH
        bot[0] -= WIDTH
      end
      while bot[1] >= HEIGHT
        bot[1] -= HEIGHT
      end

      botset.add(bot[0] * 100000 + bot[1])
    end

    if botset.size == bots.size
      puts count
      break
    end
  end
end

p1
p2
