import string

text = """The first Irish inter-county ploughing contest was held between County Wexford and County Kildare
on 16 February 1931 in a 26-acre field at Coursetown in Athy in County Kildare.
Since then, the National Ploughing Championships has expanded to over 800 acres with 1,700 exhibitors.
It has been extended beyond displays relating to ploughing, farming and machinery and now includes a tented trade
village, live entertainment and music, fashion shows, a craft village, cooking demonstrations,
sheep dog trials, pony games and other activities. In 2014, the event attracted what was then a record of
279,500 visitors, rising to 281,000 in 2015, 283,000 in 2016 and 291,500 in 2017.
The original mission statement for the National Ploughing Association, the body which organises the event,
was set out as bringing 'the message of good ploughing to all parts of the country and to provide a pleasant
and friendly place to meet and do business' """

# 1. Dictionary of word -> frequency
# lowercase so "The" and "the" count as the same word,
# and strip punctuation from the ends of each word (commas, full stops, quotes)
word_count = {}
for word in text.split():
    word = word.lower().strip(string.punctuation)
    if word == "":
        continue
    if word in word_count:
        word_count[word] += 1
    else:
        word_count[word] = 1

print("1. Word frequencies:")
print(word_count)

# 2. Words whose frequency is greater than 2
print("\n2. Words that appear more than 2 times:")
for word, count in word_count.items():
    if count > 2:
        print(word, count)

# 3. New dictionary with only the keys longer than 5 characters
long_words = {word: count for word, count in word_count.items() if len(word) > 5}
print("\n3. Words longer than 5 characters:")
print(long_words)