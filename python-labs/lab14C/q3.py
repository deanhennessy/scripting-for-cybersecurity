data = ([7, 5, 4], [0, 2, 3, -4], [7, 5, 4, 5])

# Sort each list (returns a new tuple of sorted lists)
sorted_data = tuple(sorted(lst) for lst in data)
print(sorted_data)