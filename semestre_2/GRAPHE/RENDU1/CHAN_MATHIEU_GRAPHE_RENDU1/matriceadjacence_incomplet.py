#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Implémentation d'un graphe à l'aide d'une matrice d'adjacence. Les n sommets
sont identifiés par de simples naturels (0, 1, 2, ..., n-1)."""


class MatriceAdjacence(object):
    def __init__(self, num=0):
        """Initialise un graphe sans arêtes sur num sommets."""
        self._matrice_adjacence = [[0] * num for _ in range(num)]

    def ajouter_arete(self, source, destination):
        """Ajoute l'arête {source, destination} au graphe, en créant les
        sommets manquants le cas échéant. """
        length_matrice = len(self._matrice_adjacence)
        nb_sommets = 0
        # on détermine le nombre total de sommets il doit y avoir
        if source < destination:
            nb_sommets = destination + 1
        else:
            nb_sommets = source + 1
        # on agrandit la matrice si des sommets doivent être ajouté
        if nb_sommets >= length_matrice:
            for liste in self._matrice_adjacence:
                liste.extend([0] * (nb_sommets - len(liste)))
            for i in range(nb_sommets - length_matrice):
                self._matrice_adjacence.append([0] * nb_sommets)
        # on ajoute l'arête
        self._matrice_adjacence[source][destination] = 1
        if source != destination:
            self._matrice_adjacence[destination][source] = 1

    def ajouter_aretes(self, iterable):
        """Ajoute toutes les arêtes de l'itérable donné au graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples de naturels."""
        for i, j in iterable:
            self.ajouter_arete(i, j)

    def ajouter_sommet(self):
        """Ajoute un nouveau sommet au graphe et renvoie son identifiant."""
        length_matrice = len(self._matrice_adjacence)
        self._matrice_adjacence.append([0]*(length_matrice + 1))
        for i in range(length_matrice):
            self._matrice_adjacence[i].append(0)
        return length_matrice

    def aretes(self):
        """Renvoie l'ensemble des arêtes du graphe sous forme de couples (si on
        les stocke sous forme de paires, on ne peut pas stocker les boucles,
        c'est-à-dire les arêtes de la forme (u, u))."""
        aretes = set()
        length_matrice = len(self._matrice_adjacence)
        for i in range(length_matrice):
            for j in range(i, length_matrice):
                if self._matrice_adjacence[i][j] == 1 and i != j and (j, i) not in aretes:
                    aretes.add(frozenset((i, j)))
        return aretes
            

    def boucles(self):
        """Renvoie les boucles du graphe, c'est-à-dire les arêtes reliant un
        sommet à lui-même."""
        boucles = set()
        for i in range(len(self._matrice_adjacence)):
            if self._matrice_adjacence[i][i] == 1:
                boucles.add(i)
        return boucles

    def contient_arete(self, u, v):
        """Renvoie True si l'arête {u, v} existe, False sinon."""
        return self._matrice_adjacence[u][v] == 1

    def contient_sommet(self, u):
        """Renvoie True si le sommet u existe, False sinon."""
        return u < len(self._matrice_adjacence)

    def degre(self, sommet):
        """Renvoie le degré d'un sommet, c'est-à-dire le nombre de voisins
        qu'il possède."""
        degre = 0
        for j in range(len(self._matrice_adjacence[sommet])):
            if sommet != j:
                degre += self._matrice_adjacence[sommet][j]
        return degre

    def nombre_aretes(self):
        """Renvoie le nombre d'arêtes du graphe."""
        return len(self.aretes())

    def nombre_boucles(self):
        """Renvoie le nombre d'arêtes de la forme {u, u}."""
        return len(self.boucles())

    def nombre_sommets(self):
        """Renvoie le nombre de sommets du graphe."""
        return len(self._matrice_adjacence)

    def retirer_arete(self, u, v):
        """Retire l'arête {u, v} si elle existe; provoque une erreur sinon."""
        if self._matrice_adjacence[u][v] == 1:
            self._matrice_adjacence[u][v] = 0
            self._matrice_adjacence[v][u] = 0
        else:
            raise Exception("No such edge")

    def retirer_aretes(self, iterable):
        """Retire toutes les arêtes de l'itérable donné du graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples d'éléments (quel que soit le type du couple)."""
        for i, j in iterable:
            self.retirer_arete(i, j)

    def retirer_sommet(self, sommet):
        """Déconnecte un sommet du graphe et le supprime."""
        length_matrice = len(self._matrice_adjacence)
        for j in range(length_matrice):
            if self._matrice_adjacence[sommet][j] != 0:
                self.retirer_arete(sommet, j)
            
    def retirer_sommets(self, iterable):
        """Efface les sommets de l'itérable donné du graphe, et retire toutes
        les arêtes incidentes à ces sommets."""
        for sommet in iterable:
            self.retirer_sommet(sommet)

    def sommets(self):
        """Renvoie l'ensemble des sommets du graphe."""
        sommets = set()
        for i in range(len(self._matrice_adjacence)):
            if 1 in self._matrice_adjacence[i]:
                sommets.add(i)
        return sommets

    def sous_graphe_induit(self, iterable):
        """Renvoie le sous-graphe induit par l'itérable de sommets donné."""
        length_matrice = len(self._matrice_adjacence)
        sous_graphe = MatriceAdjacence(length_matrice)
        for i in iterable:
            for j in iterable:
                if self._matrice_adjacence[i][j] == 1:
                    sous_graphe.ajouter_arete(i, j)
        return sous_graphe

    def voisins(self, sommet):
        """Renvoie la liste des voisins d'un sommet."""
        voisins = set()
        for i in range(len(self._matrice_adjacence)):
            if self._matrice_adjacence[sommet][i] == 1 and i != sommet:
                voisins.add(i)
        return voisins

def export_dot(graphe):
    """Renvoie une chaîne encodant le graphe au format dot."""
    chaine = "graph G {\n"
    for i in graphe.sommets():
        chaine += "    {};\n".format(i)
    for i, j in graphe.aretes():
        chaine += "    {} -- {};\n".format(i, j)
    for i in graphe.boucles():
        chaine += "    {} -- {};\n".format(i, i)
    chaine += "}"
    return chaine 


def main():
    import doctest
    doctest.testfile("doctest_matriceadjacence.txt")

if __name__ == "__main__":
    main()
