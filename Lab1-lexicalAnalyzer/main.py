from ProgramInternalForm import ProgramInternalForm
from Scanner import generateToken, isIdentifier, isConstant
from MyLanguageSpecification import *
from SymbolTable import SymbolTable
from HashTable import HashTable

if __name__ == '__main__':
    filename = input('Insert file name:')

    file = open(filename, 'r')
    for line in file:
        print(line)

    with open(filename, 'r') as file:
        for line in file:
            print([token for token in generateToken(line, separators)])

    identifierSymbolTable = SymbolTable()
    constantSymbolTable = SymbolTable()
    HashTable = HashTable()
    PIF = ProgramInternalForm()

    with open(filename, 'r') as file:
        noOfLine = 0

        for line in file:
            noOfLine += 1
            # generate token for the whole lines except the last one
            for token in generateToken(line[0:-1], separators):
                if token in separators + operators + reservedWords:
                    PIF.add(codification[token], -1)

                elif isIdentifier(token):
                    pos = identifierSymbolTable.add(token)
                    PIF.add(codification['identifier'], HashTable.hashCode(token))

                elif isConstant(token):
                    pos = constantSymbolTable.add(token)
                    PIF.add(codification['constant'], HashTable.hashCode(token))

                else:
                    raise Exception('Unknown token ' + token + ' at line ' + str(noOfLine))

        with open('D:\\An 3\\Sem 1\\LFTC\\Lab1-lexicalAnalyzer\\outputs\\PIF.txt', 'w') as f:
            f.write('The Program Internal Form:\n')
            for e in PIF.getPIF():
                f.write("%s\n" % str(e))

        f.close()

        with open('D:\\An 3\\Sem 1\\LFTC\\Lab1-lexicalAnalyzer\\outputs\\ConstantSymbolTable.txt', 'w') as f:
            f.write('The Constant Symbol Table:\n')
            res = []
            for i in sorted(constantSymbolTable.getHashTable()):
                if i not in res:
                    res.append(i)
            for e in res:
                f.write("%s\n" % str(e))

        f.close()

        with open('D:\\An 3\\Sem 1\\LFTC\\Lab1-lexicalAnalyzer\\outputs\\IdentifierSymbolTable.txt', 'w') as f:
            f.write('The Identifier Symbol Table:\n')
            res = []
            for i in sorted(identifierSymbolTable.getHashTable()):
                if i not in res:
                    res.append(i)
            for e in res:
                f.write("%s\n" % str(e))

        f.close()

        print('\n\nCodification table: ')
        for e in codification:
            print(e, " -> ", codification[e])

        f.close()
