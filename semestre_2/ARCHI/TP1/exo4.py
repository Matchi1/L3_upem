l = [20, 32, 100]
a = 0.
b = 0.
c = 0.

for elt in l:
    trueValue = 0
    for i in range(elt):
        for j in range(elt):
            a = i / elt
            b = j / elt
            c = (i + j) / elt
            if a + b == c:
                trueValue += 1
    print("pourcentage de valeur vraies: {}".format((trueValue * 100) / (elt * elt)))

