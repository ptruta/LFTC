class ProgramInternalForm:
    def __init__(self):
        self.__content = []

    def __str__(self):
        return str(self.__content)

    def add(self, code, id):
        self.__content.append((code, id))

    def getPIF(self):
        return self.__content
