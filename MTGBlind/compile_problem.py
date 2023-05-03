def compile_problem():
    current_problem = open("mtg-current-problem.pddl", "w")
    base_template_first_half  = open("base_template_first_half.txt", "r")
    base_template_second_half  = open("base_template_second_half.txt", "r")
    inits_template = (open("inits_template.txt", "r"))

    current_problem.write(base_template_first_half.read())
    current_problem.write(inits_template.read())
    current_problem.write(base_template_second_half.read())

    current_problem.close()
    base_template_first_half.close()
    base_template_second_half.close()
    inits_template.close()
    
compile_problem()