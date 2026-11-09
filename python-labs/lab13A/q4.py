def student_details(student_name, student_id, module_name="Scripting for Cyber"):

    print("Name:", student_name)

    print("ID:", student_id)
    
    print("Module:", module_name)


# call with name first, then ID (positional arguments)
student_details("Dean Hennessy", "C00325399")

print()

# pass the ID first using keyword arguments
student_details(student_id="C00325399", student_name="Dean Hennessy")