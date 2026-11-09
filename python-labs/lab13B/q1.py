def same_elements(list1, list2):
    # work on copies so the original lists are not changed
    list1 = list1.copy()
    list2 = list2.copy()

    # loop over a copy of list1, because we delete from list1 while looping
    for item in list1.copy():
        if item in list2:
            list1.remove(item)
            list2.remove(item)

    # if both lists are now empty, every element was matched
    return len(list1) == 0 and len(list2) == 0


# Tests
# list1 = [1,2,3,4,5], list2 = [5,4,3,2,1]   -> True (same elements, different order)
print(same_elements([1, 2, 3, 4, 5], [5, 4, 3, 2, 1]))

# list1 = [1,2,3,4,5], list2 = [1,2,3,4,6]   -> False (5 and 6 do not match)
print(same_elements([1, 2, 3, 4, 5], [1, 2, 3, 4, 6]))

# list1 = [1,2,3], list2 = [1,2,3,4]         -> False (different lengths)
print(same_elements([1, 2, 3], [1, 2, 3, 4]))

# list1 = [1,1,2], list2 = [1,2,2]           -> False (duplicates do not match)
print(same_elements([1, 1, 2], [1, 2, 2]))

# list1 = ['a','b','c'], list2 = ['c','a','b'] -> True (works with strings too)
print(same_elements(['a', 'b', 'c'], ['c', 'a', 'b']))

# list1 = [], list2 = []                     -> True (both empty)
print(same_elements([], []))