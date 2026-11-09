sentence = "The quick brown fox jumps over the lazy dog"

words = sentence.split()

print(words)

long_words = [w for w in words if len(w) > 3]

print(long_words)