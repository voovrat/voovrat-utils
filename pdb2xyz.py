cat 2-methylbutaneX.pdb | grep ATOM | gawk '{print $6"  "$7"  "$8 }'
