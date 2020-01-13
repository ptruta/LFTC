class Grammar:

    def __init__(self, N, E, P, S):
        self.N = N
        self.E = E
        self.P = P
        self.S = S

    def is_non_terminal(self, value):
        if value in self.N:
            return True
        return False

    def is_terminal(self, value):
        if value in self.E:
            return True
        return False

    def is_regular(self):
        used_in_rhs = dict()
        not_allowed_in_rhs = list()

        for rule in self.P:
            lhs, rhs = rule
            has_terminal = False
            has_non_terminal = False

            if len(rhs) > 2:
                return False

            for char in rhs:
                if self.is_non_terminal(char):
                    used_in_rhs[char] = True
                    has_non_terminal = True
                elif self.is_terminal(char):
                    if has_non_terminal:
                        return False
                    has_terminal = True
                if char == 'E':
                    not_allowed_in_rhs.append(lhs)

            if has_non_terminal and not has_terminal:
                return False

        for char in not_allowed_in_rhs:
            if char in used_in_rhs:
                return False

        return True

    @staticmethod
    def line_parsed(line):
        # returns after the equal sign and the element before and after the coma
        return [element.strip() for element in line.strip().split('=')[1].strip()[1:-1].strip().split(',')]

    @staticmethod
    def console_parsed(line):
        # returns the element before and after the coma
        return [element.strip() for element in line.strip()[1:-1].strip().split(',')]

    @staticmethod
    def rules_parsed(rules):
        result = []

        for rule in rules:
            lhs, rhs = rule.split('->')
            lhs = lhs.strip()  # eliminate the spaces from front and back of the string
            rhs = [element.strip() for element in rhs.split('|')]

            for element in rhs:
                result.append((lhs, element))

        return result

    @staticmethod
    def read_from_file(file_name):
        with open(file_name) as f:
            N = Grammar.line_parsed(f.readline())
            E = Grammar.line_parsed(f.readline())
            S = f.readline().split('=')[1].strip()
            P = Grammar.rules_parsed(Grammar.line_parsed(''.join([line for line in f])))

            return Grammar(N, E, P, S)

    @staticmethod
    def read_from_console():
        N = Grammar.console_parsed(input('N = '))
        E = Grammar.console_parsed(input('E = '))
        S = input('S = ')
        P = Grammar.rules_parsed(Grammar.console_parsed(input('P = ')))

        return Grammar(N, E, P, S)

    @staticmethod
    def get_rg_from_finite_automaton(fa):
        N = fa.Q
        E = fa.E
        S = fa.q0
        lhs1, state0 = S
        state01, route1 = lhs1, state0
        P = []
        P.append((state0, route1 + state01))

        for transition in fa.S:
            lhs, state2 = transition
            state1, route = lhs

            P.append((state1, route + state2))

            if state2 in fa.F:
                P.append((state1, route))

        return Grammar(N, E, P, S)

    def get_productions_for(self, nonTerminal):
        if not self.is_non_terminal(nonTerminal):
            raise Exception('Can only show productions for non-terminals')

        return [prod for prod in self.P if prod[0] == nonTerminal]

    def show_productions_for(self, nonTerminal):
        productions = self.get_productions_for(nonTerminal)

        print(', '.join([' -> '.join(prod) for prod in productions]))

    def __str__(self):
        return 'N = { ' + ', '.join(self.N) + ' }\n' \
               + 'E = { ' + ', '.join(self.E) + ' }\n' \
               + 'P = { ' + ', '.join([' -> '.join(prod) for prod in self.P]) + ' }\n' \
               + 'S = ' + str(self.S) + '\n'
