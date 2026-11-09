def replace_vowels(original):
    vowels = "aeiouAEIOU"
    counter = 1          # the integer that replaces each vowel
    new_list = []

    for item in original:
        if item in vowels:
            new_list.append(counter)
            counter += 1
        else:
            new_list.append(item)

    return new_list


# testing
list1 = ['a', 'b', 'c', 'd', 'e']
print(replace_vowels(list1))

list3 = ['a', 'a', 'a']
print(replace_vowels(list3))

list4 = ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd']
print(replace_vowels(list4))