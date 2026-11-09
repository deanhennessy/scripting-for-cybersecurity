a = 20
b = 30
c = 40
d = 50

num = int(input("Enter a number between 20 and 50: "))

# first check the number is in the overall range a to d
if a <= num <= d:
    print("The number is in the range of a and d")

    # then find which section it falls in
    if num <= b:
        print("The number is between a and b")
    
    elif num <= c:
        print("The number is between b and c")
    
    else:
        print("The number is between c and d")

else:
    print("The number is outside the range of a and d")