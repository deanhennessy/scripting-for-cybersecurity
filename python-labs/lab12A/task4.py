word = input("Please enter a word: ")

reversed_word = word[::-1]

if word == reversed_word:
    print("palindrome")
else:
    print("not a palindrome")