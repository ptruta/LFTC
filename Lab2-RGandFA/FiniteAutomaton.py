class FiniteAutomaton:
    def __init__(self, Q, E, S, q0, F):
        self.Q = Q
        self.E = E
        self.S = S
        self.q0 = q0
        self.F = F

    def is_state(self, value):
        return value in self.Q

    @staticmethod
    def line_parsed(line):
        # returns after the equal sign and the element before and after the coma
        return [element.strip() for element in line.strip().split('=')[1].strip()[1:-1].strip().split(',')]

    @staticmethod
    def console_parsed(line):
        # returns the element before and after the coma
        return [element.strip() for element in line.strip()[1:-1].strip().split(',')]

    @staticmethod
    def read_from_file(fileName):
        with open(fileName) as f:
            Q = FiniteAutomaton.line_parsed(f.readline())
            E = FiniteAutomaton.line_parsed(f.readline())
            q0 = f.readline().split('=')[1].strip()
            F = FiniteAutomaton.line_parsed(f.readline())

            S = FiniteAutomaton.transactions_parsed(FiniteAutomaton.line_parsed(''.join([line for line in f])))

            return FiniteAutomaton(Q, E, S, q0, F)

    @staticmethod
    def read_from_console():
        Q = FiniteAutomaton.console_parsed(input('Q = '))
        E = FiniteAutomaton.console_parsed(input('E = '))
        q0 = input('q0 = ')
        F = FiniteAutomaton.console_parsed(input('F = '))

        S = FiniteAutomaton.transactions_parsed(FiniteAutomaton.console_parsed(input('S = ')))

        return FiniteAutomaton(Q, E, S, q0, F)

    @staticmethod
    def transactions_parsed(parts):
        result = []
        transitions = []
        index = 0

        while index < len(parts):
            transitions.append(parts[index] + ',' + parts[index + 1])
            index += 2

        for transition in transitions:
            lhs, rhs = transition.split('->')
            state2 = rhs.strip()
            state1, route = [value.strip() for value in lhs.strip()[1:-1].split(',')]

            result.append(((state1, route), state2))

        return result

    @staticmethod
    def get_fa_from_regular_grammar(rg):
        Q = rg.N + ['K']
        E = rg.E
        q0 = rg.S
        F = ['K']

        S = []

        for production in rg.P:
            state2 = 'K'
            state1, rhs = production
            if state1 == q0 and rhs[0] == 'E':
                F.append(q0)
                continue

            route = rhs[0]

            if len(rhs) == 2:
                state2 = rhs[1]

            S.append(((state1, route), state2))

        return FiniteAutomaton(Q, E, S, q0, F)

    def get_transactions_for(self, state):
        if not self.is_state(state):
            raise Exception('Can only get transitions for states')

        return [trans for trans in self.S if trans[0][0] == state]

    def show_transitions_for(self, state):
        transitions = self.get_transactions_for(state)

        print('{ ' + ' '.join([' -> '.join([str(part) for part in trans]) for trans in transitions]) + ' }')

    def __str__(self):
        return 'Q = { ' + ', '.join(self.Q) + ' }\n' \
               + 'E = { ' + ', '.join(self.E) + ' }\n' \
               + 'F = { ' + ', '.join(self.F) + ' }\n' \
               + 'S = { ' + ', '.join([' -> '.join([str(part) for part in trans]) for trans in self.S]) + ' }\n' \
               + 'q0 = ' + str(self.q0) + '\n'

