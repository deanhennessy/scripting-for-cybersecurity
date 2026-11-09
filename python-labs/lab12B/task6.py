nums = [789, -4, 10, 20, 30, 50, 60, 80, 23]

smallest = nums[0]
largest = nums[0]

for n in nums:
    if n < smallest:
        smallest = n
    if n > largest:
        largest = n

print("Smallest:", smallest)
print("Largest:", largest)