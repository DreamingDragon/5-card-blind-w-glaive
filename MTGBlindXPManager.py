import sys
sys.path.append("MTGBlind")
import compile_problem

exit_condition_met = 0
EXIT_PHRASE = "quit"

introduction = open("MTGBlind\introduction.txt", "r")
problem_statement = open("MTGBlind\problem_statement_1.txt", "r")

print(introduction.read())
print(problem_statement.read())

while (not exit_condition_met):
    print("You have priority. How would you like to respond?")
    user_responce = input()
    
    if (user_responce == EXIT_PHRASE):
        exit_condition_met = 1