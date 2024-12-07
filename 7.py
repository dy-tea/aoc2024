def valid(result, components, sum) -> bool:
    if len(components) == 0:
        return result == sum

    lhs = sum
    rhs = int(components[0])

    if valid(result, components[1:], lhs + rhs):
        return True

    if valid(result, components[1:], lhs * rhs) and lhs != 0:
        return True

def p1():
    with open('input', 'r') as f:
        cum = 0

        for line in f:
            res, other = line.split(': ')
            res = int(res)
            nums = other.split(' ')
            
            if valid(res, nums, 0):
                cum += res

        print(cum)

def valid2(result, components, sum) -> bool:
    if len(components) == 0:
        return int(result) == int(sum)

    lhs = str(sum)
    rhs = str(components[0])

    if valid2(result, components[1:], str(int(lhs) + int(rhs))):
        return True

    if valid2(result, components[1:], str(int(lhs) * int(rhs))) and lhs != "0":
        return True

    if valid2(result, components[1:], "".join([lhs, rhs])):
        return True

def p2():
    with open('input', 'r') as f:
        cum = 0

        for line in f:
            res, other = line.split(': ')
            nums = other.split(' ')

            if valid2(res, nums, "0"):
                cum += int(res)
        
        print(cum)

p1()
p2()
