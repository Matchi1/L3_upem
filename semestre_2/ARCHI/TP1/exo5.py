l = [20, 32, 100]
a = 0.
b = 0.
c = 0.
Cgreater = True

for elt in l:
    trueValue = 0
    for i in range(elt):
        for j in range(elt):
            a = i / elt
            b = j / elt
            c = (i + j) / elt
            if a + b < c:
                Cgreater = True
            else:
                Cgreater = False
            if a + b + 0.000001 < c + 0.000001 and Cgreater:
                trueValue += 1
            elif a + b + 0.000001 > c + 0.000001 and not Cgreater:
                trueValue += 1
    print("pourcentage de valeur vraies: {}".format((trueValue * 100) / (elt * elt)))

