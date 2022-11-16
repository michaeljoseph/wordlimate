from pydantic import BaseModel

"""
B = black => letter missing from word
Y = yellow => letter present but wrong position
G = green => letter present and correct position
"""
MISSING = "B"
PRESENT = "Y"
CORRECT = "G"


class Guess(BaseModel):
    word: str
    feedback: str

    def constraints(self) -> str:
        conditions = []
        for i in range(len(self.word)):
            l = self.word[i]
            f = self.feedback[i]

            if f == MISSING:
                conditions.append(lambda word: l not in word.split())
            elif f == PRESENT:
                conditions.append(lambda word: l in word.split() and word[i] != l)
            elif f == CORRECT:
                conditions.append(lambda word: word[i] == self.word[i])

        return conditions
