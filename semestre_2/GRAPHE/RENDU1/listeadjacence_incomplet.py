#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Implémentation d'un graphe à l'aide d'une liste d'adjacence. Les n sommets
sont identifiés par de simples naturels (0, 1, 2, ..., n-1)."""


class ListeAdjacence(object):
    def __init__(self, num=0):
        """Initialise un graphe sans arêtes sur num sommets.

        >>> G = ListeAdjacence()
        >>> G._liste_adjacence
        []
        """
        self._liste_adjacence = [list() for _ in range(num)]

    def ajouter_arete(self, source, destination):
        """Ajoute l'arête {source, destination} au graphe, en créant les
        sommets manquants le cas échéant.

        >>> g = ListeAdjacence()
        >>> g.ajouter_arete(2, 3);
        >>> g._liste_adjacence
        [[], [], [3], [2]]
        """
        tmp = 0
        length = len(self._liste_adjacence)
        if source > destination:
            tmp = source
        else:
            tmp = destination
        if tmp > length:
            for _ in range(tmp - length + 1):
                self._liste_adjacence.append(list())

        self._liste_adjacence[source].append(destination)
        self._liste_adjacence[destination].append(source)
        pass  # à compléter

    def ajouter_aretes(self, iterable):
        """Ajoute toutes les arêtes de l'itérable donné au graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples de naturels.

        >>> aretes = [(1, 2), (1, 3), (2, 4)]
        >>> g = ListeAdjacence(5)
        >>> g.ajouter_aretes(aretes);
        >>> g._liste_adjacence
        [[], [2, 3], [1, 4], [1], [2]]
        """
        for i, j in iterable:
            self.ajouter_arete(i, j)
        pass  # à compléter

    def ajouter_sommet(self):
        """Ajoute un nouveau sommet au graphe et renvoie son identifiant.

        >>> G = ListeAdjacence()
        >>> G.ajouter_sommet()
        0
        >>> G._liste_adjacence
        [[]]
        >>> G.ajouter_sommet()
        1
        >>> G._liste_adjacence
        [[], []]
        """
        ident = len(self._liste_adjacence)
        self._liste_adjacence.append(list())
        return ident

    def aretes(self):
        """Renvoie l'ensemble des arêtes du graphe sous forme de couples (si on
        les stocke sous forme de paires, on ne peut pas stocker les boucles,
        c'est-à-dire les arêtes de la forme (u, u)).

        >>> aretes = [(1, 1), (1, 2), (1, 3), (2, 4)]
        >>> g = ListeAdjacence(5)
        >>> g.ajouter_aretes(aretes);
        >>> g.aretes()
        [(1, 2), (1, 3), (2, 4)]
        """
        return [(i, j) for i in range(len(self._liste_adjacence)) for j in self._liste_adjacence[i] if i != j]

    def boucles(self):
        """Renvoie les boucles du graphe, c'est-à-dire les arêtes reliant un
        sommet à lui-même.

        >>> aretes = [(1, 1), (1, 2), (1, 3), (2, 4), (4, 4)]
        >>> g = ListeAdjacence(5)
        >>> g.ajouter_aretes(aretes);
        >>> g.boucles()
        [1, 4]
        """
        return [i for i in range(len(self._liste_adjacence)) for j in self._liste_adjacence[i] if i == j]

    def contient_arete(self, u, v):
        """Renvoie True si l'arête {u, v} existe, False sinon.

        >>> aretes = [(1, 1), (1, 2), (1, 3), (2, 4), (4, 4)]
        >>> g = ListeAdjacence(5)
        >>> g.ajouter_aretes(aretes);
        >>> g.contient_arete(1, 2)
        True
        >>> g.contient_arete(2, 2)
        False
        """
        return v in self._liste_adjacence[u]

    def contient_sommet(self, u):
        """Renvoie True si le sommet u existe, False sinon.

        >>> aretes = [(1, 1), (1, 2), (1, 3), (2, 4), (4, 4)]
        >>> g = ListeAdjacence(5)
        >>> g.ajouter_aretes(aretes);
        >>> g.contient_sommet(1)
        True
        >>> g.contient_sommet(5)
        False
        """
        return u < len(self._liste_adjacence)

    def degre(self, sommet):
        """Renvoie le degré d'un sommet, c'est-à-dire le nombre de voisins
        qu'il possède.

        >>> aretes = [(1, 1), (1, 2), (1, 3), (2, 4), (4, 4)]
        >>> g = ListeAdjacence(5)
        >>> g.ajouter_aretes(aretes);
        >>> g.degre(1)
        3
        """
        return len(self._liste_adjacence[sommet])

    def nombre_aretes(self):
        """Renvoie le nombre d'arêtes du graphe.

        >>> aretes = [(1, 1), (1, 2), (1, 3), (2, 4), (4, 4)]
        >>> g = ListeAdjacence(5)
        >>> g.ajouter_aretes(aretes);
        >>> g.nombre_aretes()
        5
        """
        aretes = 0
        for i in range(len(self._liste_adjacence)):
            aretes += len(self._liste_adjacence[i])
        return aretes

    def nombre_boucles(self):
        """Renvoie le nombre d'arêtes de la forme {u, u}.
        
        >>> aretes = [(1, 1), (1, 2), (1, 3), (2, 4), (4, 4)]
        >>> g = ListeAdjacence(5)
        >>> g.ajouter_aretes(aretes);
        >>> g.nombre_boucles()
        2
        """
        nb_boucles = 0
        for i in range(len(self._liste_adjacence)):
            if i in self._liste_adjacence[i]:
                nb_boucles += 1
        return nb_boucles

    def nombre_sommets(self):
        """Renvoie le nombre de sommets du graphe.

        >>> from random import randint
        >>> n = randint(0, 1000)
        >>> ListeAdjacence(n).nombre_sommets() == n
        True
        """
        return len(self._liste_adjacence)

    def retirer_arete(self, u, v):
        """Retire l'arête {u, v} si elle existe; provoque une erreur sinon.

        >>> aretes = [(1, 1), (1, 2), (1, 3), (2, 4), (4, 4)]
        >>> g = ListeAdjacence(5)
        >>> g.ajouter_aretes(aretes);
        >>> g.retirer_arete(1, 1)
        >>> g._liste_adjacence
        [[], [2, 3], [4], [], [4]]
        >>> g.retirer_arete(1, 1)
        Traceback (most recent call last):
            ...
        ValueError: list.remove(x): x not in list
        """
        self._liste_adjacence[u].remove(v)

    def retirer_aretes(self, iterable):
        """Retire toutes les arêtes de l'itérable donné du graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples d'éléments (quel que soit le type du couple).

        >>> a_retirer = [(1, 1), (2, 4)]
        >>> aretes = [(1, 1), (1, 2), (1, 3), (2, 4), (4, 4)]
        >>> g = ListeAdjacence(5)
        >>> g.ajouter_aretes(aretes);
        >>> g.retirer_aretes(a_retirer)
        >>> g._liste_adjacence
        [[], [2, 3], [], [], [4]]
        """
        for (i, j) in iterable:
            self.retirer_arete(i, j)

    def retirer_sommet(self, sommet):
        """Déconnecte un sommet du graphe et le supprime.
        
        >>> aretes = [(1, 1), (1, 2), (1, 3), (2, 4), (4, 4)]
        >>> g = ListeAdjacence(5)
        >>> g.ajouter_aretes(aretes);
        >>> g.retire_sommet(1)
        """
        for i in range(len(self._liste_adjacence)):
            if sommet in self._liste_adjacence[i]:
                self._liste_adjacence.retirer_arete(i, sommet)
        self._liste_adjacence.pop(sommet)

    def retirer_sommets(self, iterable):
        """Efface les sommets de l'itérable donné du graphe, et retire toutes
        les arêtes incidentes à ces sommets."""
        pass  # à compléter

    def sommets(self):
        """Renvoie l'ensemble des sommets du graphe."""
        pass  # à compléter

    def sous_graphe_induit(self, iterable):
        """Renvoie le sous-graphe induit par l'itérable de sommets donné."""
        pass  # à compléter

    def voisins(self, sommet):
        """Renvoie la liste des voisins d'un sommet."""
        pass  # à compléter


def main():
    import doctest
    doctest.testmod()


if __name__ == "__main__":
    main()
