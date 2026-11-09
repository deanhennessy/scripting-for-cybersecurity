def get_words():
    # returns a list of words
    return ["apple", "ball", "cat", "dog", "apple"]


def get_numbers():
    # returns a set of numbers
    return {1, 2, 3, 4, 5}


words = get_words()
numbers = get_numbers()

print("List of words:", words)
print("Set of numbers:", numbers)

# update the set with the elements of the list
# (a set has no duplicates, so the second "apple" is only added once)
numbers.update(words)

print("Set after update:", numbers)