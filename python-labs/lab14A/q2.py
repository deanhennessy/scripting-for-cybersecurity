# Q2 Reverse key with value in a dictionary.
# E.g. {5: 25, 6: 36, 7: 49} -> {25: 5, 36: 6, 49: 7}

d = {5: 25, 6: 36, 7: 49}

# dictionary comprehension: swap each key and value
reversed_d = {value: key for key, value in d.items()}
print(reversed_d)

# the same thing with a normal loop
reversed_d2 = {}
for key, value in d.items():
    reversed_d2[value] = key
print(reversed_d2)