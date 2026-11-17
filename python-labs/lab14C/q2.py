# Key: frozenset({name, student number}), Value: (marks in module 1, marks in module 2)
students = {
    frozenset({"John", "C00012322"}): (84, 45),
    frozenset({"Mary", "C00012323"}): (72, 90),
    frozenset({"Aoife", "C00012324"}): (65, 58),
}

for key, marks in students.items():
    print(sorted(key), "->", marks)

# Lookup works regardless of the order of the elements in the key
print(students[frozenset({"C00012322", "John"})])