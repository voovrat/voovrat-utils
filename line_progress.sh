#!/bin/bash
N=0;
while [ 1 == 1 ]; 
do 
  N1=$(cat $1 | wc -l); 
  [ $N == $N1 ]||echo $N1; 
  N=$N1; 
  sleep 1; 
done
