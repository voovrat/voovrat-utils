#!/bin/bash

P=$(pwd)

a_List=$(cat a.list)
b_List=$(cat b.list)
c_List=$(cat c.list)

 for a in $a_List
 do
	 for b in $b_List
	 do
		 for c in $c_List
		 do
			 cd $P
			 . $*
		 done
	 done
 done
