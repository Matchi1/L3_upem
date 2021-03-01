#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Implémentation d'un graphe à l'aide d'une liste d'adjacence. Les n sommets
sont identifiés par de simples naturels (0, 1, 2, ..., n-1)."""


class ListeAdjacence(object):
    def __init__(self, num=0):
        """Initialise un graphe sans arêtes sur num sommets."""
        self._liste_adjacence = [list() for _ in range(num)]

    def ajouter_arete(self, source, destination):
        """Ajoute l'arête {source, destination} au graphe, en créant les
        sommets manquants le cas échéant."""
        # on vérifie si le premier sommet existe déjà dans la liste
        if source >= len(self._liste_adjacence):
            for i in range(len(self._liste_adjacence) - 1, source):
                self._liste_adjacence.append(list())
        # on vérifie si le deuxième sommet existe déjà dans la liste
        if destination >= len(self._liste_adjacence):
            for i in range(len(self._liste_adjacence) - 1, destination):
                self._liste_adjacence.append(list())
        # on vérifie si l'arête est déjà présente dans la liste
        if destination not in self._liste_adjacence[source]:
            self._liste_adjacence[source].append(destination)
            if source != destination:
                self._liste_adjacence[destination].append(source)

    def ajouter_aretes(self, iterable):
        """Ajoute toutes les arêtes de l'itérable donné au graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples de naturels."""
        for i, j in iterable:
            self.ajouter_arete(i, j)

    def ajouter_sommet(self):
        """Ajoute un nouveau sommet au graphe et renvoie son identifiant."""
        self._liste_adjacence.append(list())
        return len(self._liste_adjacence) - 1

    def aretes(self):
        """Renvoie l'ensemble des arêtes du graphe sous forme de couples (si on
        les stocke sous forme de paires, on ne peut pas stocker les boucles,
        c'est-à-dire les arêtes de la forme (u, u))."""
        aretes = set()
        for i in range(len(self._liste_adjacence)):
            liste = self._liste_adjacence[i]
            if liste != []:
                for j in liste:
                    if i != j and (j, i) not in aretes:
                        aretes.add(frozenset((i, j)))
        return aretes

    def boucles(self):
        """Renvoie les boucles du graphe, c'est-à-dire les arêtes reliant un
        sommet à lui-même."""
        boucles = set()
        for i in range(len(self._liste_adjacence)):
            liste = self._liste_adjacence[i]
            if liste != []:
                if i in liste:
                    boucles.add(i)
        return boucles

    def contient_arete(self, u, v):
        """Renvoie True si l'arête {u, v} existe, False sinon."""
        liste = self._liste_adjacence[u]
        return v in liste

    def contient_sommet(self, u):
        """Renvoie True si le sommet u existe, False sinon."""
        return u < len(self._liste_adjacence)

    def degre(self, sommet):
        """Renvoie le degré d'un sommet, c'est-à-dire le nombre de voisins
        qu'il possède."""
        liste = self._liste_adjacence[sommet]
        if sommet in self._liste_adjacence[sommet]:
            return len(self._liste_adjacence[sommet]) - 1
        return len(self._liste_adjacence[sommet])

    def nombre_aretes(self):
        """Renvoie le nombre d'arêtes du graphe."""
        return len(self.aretes())

    def nombre_boucles(self):
        """Renvoie le nombre d'arêtes de la forme {u, u}."""
        return len(self.boucles())

    def nombre_sommets(self):
        """Renvoie le nombre de sommets du graphe."""
        return len(self._liste_adjacence)

    def retirer_arete(self, u, v):
        """Retire l'arête {u, v} si elle existe; provoque une erreur sinon."""
        liste = self._liste_adjacence[u]
        liste2 = self._liste_adjacence[v]
        liste.remove(v)
        if u != v:
            liste2.remove(u)

    def retirer_aretes(self, iterable):
        """Retire toutes les arêtes de l'itérable donné du graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples d'éléments (quel que soit le type du couple)."""
        for (i, j) in iterable:
            self.retirer_arete(i, j)

    def retirer_sommet(self, sommet):
        """Déconnecte un sommet du graphe et le supprime."""
        length_liste = len(self._liste_adjacence)
        for i in range(length_liste):
            liste = self._liste_adjacence[i]
            if liste != []:
                if sommet in liste:
                    self.retirer_arete(sommet, i)
        self._liste_adjacence[sommet].clear()

    def retirer_sommets(self, iterable):
        """Efface les sommets de l'itérable donné du graphe, et retire toutes
        les arêtes incidentes à ces sommets."""
        for sommet in iterable:
            self.retirer_sommet(sommet)

    def sommets(self):
        """Renvoie l'ensemble des sommets du graphe."""
        length_liste = len(self._liste_adjacence)
        sommets = set()
        for sommet in range(length_liste):
            if self._liste_adjacence[sommet] != []:
                sommets.add(sommet)
        return sommets


    def sous_graphe_induit(self, iterable):
        """Renvoie le sous-graphe induit par l'itérable de sommets donné."""
        sous_graphe = ListeAdjacence(len(self._liste_adjacence))
        for i in iterable:
            for j in iterable:
                if j in self._liste_adjacence[i]:
                    sous_graphe.ajouter_arete(i, j)
        return sous_graphe 

    def voisins(self, sommet):
        """Renvoie la liste des voisins d'un sommet."""
        voisins = set()
        for i in self._liste_adjacence[sommet]:
            if i != sommet:
                voisins.add(i)
        return voisins

def main():
    import doctest
    doctest.testfile("doctest_listeadjacence.txt")

if __name__ == "__main__":
    main()
