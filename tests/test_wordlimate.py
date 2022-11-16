from wordlimate.models import CORRECT, MISSING, PRESENT, Guess


def test_correct():
    solution = "hello"
    g = Guess(word=solution, feedback=CORRECT * 5)

    assert all([c(solution) for c in g.constraints()])


def test_missing():
    solution = "hello"
    g = Guess(word="bring", feedback=MISSING * 5)

    assert all([c(solution) for c in g.constraints()])
