a = [2023, "setu", "Carlow"]
b = ["kilkenny road", "Co Carlow"]

# extend: add all elements of b to the end of a
a.extend(b)
print("After extend:", a)

# insert: 2nd position is index 1
a.insert(1, "R93 V960")
print("After insert:", a)

# pop: removes and returns the last item
removed = a.pop()
print("Popped item:", removed)
print("After pop:", a)

# index: position of "setu"
print("Index of 'setu':", a.index("setu"))

# count: how many times "setu" appears
print("Count of 'setu':", a.count("setu"))

# copy: c is a separate copy of a
c = a.copy()
print("Copy c:", c)