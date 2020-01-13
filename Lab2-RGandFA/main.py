from FiniteAutomaton import FiniteAutomaton
from Grammar import Grammar

if __name__ == '__main__':

    #  read the things from the file

    print("1.Grammar from the requested file -------------------------------")
    grammar = Grammar.read_from_file('rg1.txt')
    # grammar = Grammar.read_from_console()

    print(grammar)
    print("----------------------------------------------------------")
    print("2.Production for the grammar and no_terminal A ------------------")

    grammar.get_productions_for('A')
    grammar.show_productions_for('A')
    print("----------------------------------------------------------")

    print("3.Finite Automata ------------------")
    finiteAutomata = FiniteAutomaton.read_from_file('fa1.txt')
    # finiteAutomata = FiniteAutomaton.read_from_console()

    print(finiteAutomata)
    print("----------------------------------------------------------")

    print("3.Is regular and then  compute Fa-----------------------------------------")
    grammar = Grammar.read_from_file('rg1.txt')
    # grammar = Grammar.read_from_console()

    if grammar.is_regular():
        finiteAutomata = FiniteAutomaton.get_fa_from_regular_grammar(grammar)
        print(finiteAutomata)
    else:
        print("The grammar is not regular\n")

    print("====================================================================")
    # Finite Automata -> Regular Grammar

    print("4.From Fa compute the grammar =====================================================")
    finiteAutomata = FiniteAutomaton.read_from_file('fa1.txt')
    # finiteAutomata = FiniteAutomaton.read_from_console()

    grammar = Grammar.get_rg_from_finite_automaton(finiteAutomata)
    print(grammar)
    print("====================================================================")
