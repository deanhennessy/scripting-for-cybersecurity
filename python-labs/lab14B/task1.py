import re

text = """Excavations in the 1990s demonstrated that the Rock was first settled in the 9th century when a hill fort or dún was constructed on the site. The first known settlement on the rock was Dun Masc, or Masc’s Fort, an early Christian settlement that was pillaged in 842 by the Vikings. In 845 the Vikings of Dublin attacked the site and the abbot of Terryglass, Aed son of Dub dá Chrích, was killed there.[3] There is no clear evidence of 10th–11th century occupation.

The castle was built in the second half of the 12th century.

When the Normans arrived in Ireland in the late 12th century, Dunamase became the most important Hiberno-Norman fortification in Laois. It was Dunamase where Dermot Mac Morrough, King of Leinster, brought the wife of O'Rourke, the King of Breifne, after kidnapping her. Enlisting the help of the O'Connor clan, the O'Rourkes and O'Connors drove MacMurrough from Dunamase and he fled Ireland. MacMurrough gave Dunamase and his daughter Aoife in marriage to the Norman conqueror Strongbow in 1170 as part of a deal to enlist his help to regain his lands. The Norman invasion of Ireland then followed when Strongbow accompanied MacMurrough, along with many men, to attack and regain MacMurrogh's lands"""

# Prepare the text: remove footnote markers like [3], lowercase it,
# then pull out the words (punctuation is dropped, but apostrophes and
# hyphens inside a word are kept, e.g. o'rourke, hiberno-norman)
clean_text = re.sub(r"\[\d+\]", "", text).lower()
words = re.findall(r"\w+(?:['’-]\w+)*", clean_text)

# Build the dictionary: key = word, value = tuple of positions (starting at 1)
positions = {}
for index, word in enumerate(words, start=1):
    if word in positions:
        positions[word] = positions[word] + (index,)
    else:
        positions[word] = (index,)

# 1. Print the dictionary
print("1. Dictionary of word positions:")
for word, pos in positions.items():
    print(word, pos)

# 2. Average position of the words "the" and "in"
print("\n2. Average positions:")
for target in ("the", "in"):
    pos = positions[target]
    print(f'"{target}" appears {len(pos)} times, average position = {sum(pos) / len(pos):.2f}')

both = positions["the"] + positions["in"]
print(f'Average position of "the" and "in" together = {sum(both) / len(both):.2f}')

# 3. Set of words whose length is greater than 4
longer_than_4 = {word for word in positions if len(word) > 4}
print("\n3. Words longer than 4 characters:")
print(longer_than_4)

# 4. Set of words whose length is less than 7
shorter_than_7 = {word for word in positions if len(word) < 7}
print("\n4. Words shorter than 7 characters:")
print(shorter_than_7)

# 5. Intersection of the two sets (words with 5 or 6 characters)
print("\n5. Intersection of sets 3 and 4:")
print(longer_than_4 & shorter_than_7)