local function p1()
  -- read file into line
  local file = io.open("input", "r")
  io.input(file)

  if not file then
    print("Could not open file")
    return
  end

  local line = file:read("*all")
  file:close()

  -- read into fs
  local fs = {}
  local index = 0

  for i = 1, #line, 2 do
    local files = tonumber(line:sub(i, i))
    local free = tonumber(line:sub(i + 1, i + 1))

    if files ~= nil then
      for _ = 1, files do
        table.insert(fs, index)
      end
    end

    if free ~= nil then
      for _ = 1, free do
        table.insert(fs, -1)
      end
    end

    index = index + 1
  end

  -- compress fs
  local left = 1

  for right = #fs, 1, -1 do
    if fs[right] ~= -1 then
      while left < right and fs[left] ~= -1 do
        left = left + 1
      end

      if left < right then
        fs[left] = fs[right]
        fs[right] = -1
      end
    end
  end

  -- calculate checksum
  local sum = 0

  for i = 1, #fs, 1 do
    if fs[i] == -1 then
      break
    end
    sum = sum + fs[i] * (i - 1)
  end

  print(sum)
end

local function p2()
  -- read file into line
  local file = io.open("input", "r")
  io.input(file)

  if not file then
    print("Could not open file")
    return
  end

  local line = file:read("*all")
  file:close()

  -- read into fs
  local fs = {}
  local index = 0

  for i = 1, #line, 2 do
    local files = tonumber(line:sub(i, i))
    local free = tonumber(line:sub(i + 1, i + 1))

    if files ~= nil then
      for _ = 1, files do
        table.insert(fs, index)
      end
    end

    if free ~= nil then
      for _ = 1, free do
        table.insert(fs, -1)
      end
    end

    index = index + 1
  end

  -- compress fs
  local last = fs[#fs]
  local size = 0

  if last ~= -1 then
    size = 1
  end

  for right = #fs - 1, 1, -1 do
    -- increment size if last is the same
    if last == fs[right] then
      size = size + 1
    else
      -- last has changed, find a gap to put it in
      local gap = 0
      local prev = -1

      -- loop until you find a gap
      for left = 1, #fs do
        if fs[left] == -1 then
          -- set start to start of gap
          if gap == 0 then
            prev = left
          end

          -- if a gap is found increase gap size
          gap = gap + 1
        else
          if gap >= size then
            -- insert into gap
            for i = prev, prev + size - 1 do
              fs[i] = last
            end

            -- overwrite with -1
            for i = right + 1, right + size do
              fs[i] = -1
            end

            -- exit loop
            break
          end

          prev = -1
          gap = 0
        end

        if left > right then
          break
        end
      end

      -- reset size for new value
      size = 1
    end

    -- set last to the prev right
    last = fs[right]
  end

  for i, v in ipairs(fs) do
    print(i, v)
  end

  -- calculate checksum
  local sum = 0

  for i = 1, #fs do
    if fs[i] ~= -1 then
      sum = sum + fs[i] * (i - 1)
    end
  end

  print(sum)
end

p1()
p2()
