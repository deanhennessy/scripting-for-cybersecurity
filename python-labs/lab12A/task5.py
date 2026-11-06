n = int(input("Enter number of elements of the list to be created : "))

numbers = []
for i in range(n):
    value = int(input())
    numbers.append(value)

new_list = [numbers[0], numbers[-1]]
print(new_list)