import string

# Frozenset with all (lowercase) English letters
alphabet = frozenset(string.ascii_lowercase)
print(alphabet)

# A frozenset has no order, so use the ordered string to pair consecutive letters
letters = string.ascii_lowercase
pair_codes = {(a, b): (ord(a), ord(b)) for a, b in zip(letters, letters[1:])}
print(pair_codes)