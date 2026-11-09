# Q1 Convert a list to a dictionary. E.g. [5, 6, 7] -> {5: 25, 6: 36, 7: 49}

numbers = [5, 6, 7]

# dictionary comprehension: key is the number, value is its square
squares = {n: n ** 2 for n in numbers}
print(squares)

# the same thing with a normal loop
squares2 = {}
for n in numbers:
    squares2[n] = n * n
print(squares2)