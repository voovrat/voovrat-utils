#!/bin/bash

if [ $# -lt 3 ]; then
   echo "Usage:  draw_mol_in_water.sh  prefix mol.xyz  output.png  "
   exit
fi

prefix=$1
mol=$2
png=$3


octave -q --eval "plot_distr('$prefix','dens.tricolor');"
octave -q --eval "render_molecule('$mol','tmp.png');"
cat mol.tricolor dens.tricolor > moldens.tricolor
render3d --input moldens.tricolor --output $png

