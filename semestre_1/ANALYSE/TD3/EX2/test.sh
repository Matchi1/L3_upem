#!bin/bash

repertoire="Tests"
echo $(rm -f resultat)
for i in $(ls $repertoire)
do
    ./analyse < $repertoire/$i
    echo $i $? >> resultat
done