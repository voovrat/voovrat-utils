#!/bin/bash
#
# by Volodymyr P Sergiievskyi aka voov.rat (voov.rat@gmail.com)
#
# Usage: generate_iteration_script  [list_file1 list_file2 ...]
#
# Creates the iteration script which implements iteration procedure for the iterators from list_file1 list_file2 ...
#  The values in the list_files will be changed to the local variables of the script
#

echo '#!/bin/bash'
echo
echo P='$(pwd)'
echo

for((i=1;i<=$#;i++)) 
do
	fname=$(eval echo '$'$i )
	ListName[$i]=$(echo $fname | gawk -F '.' '{print $1}')
	echo ${ListName[i]}_List='$(cat '$fname')'
done

echo

Tab=''
for((i=1;i<=$#;i++))
do
	echo "$Tab" for ${ListName[i]} in '$'${ListName[i]}_List	
	echo "$Tab" do
	Tab=$Tab$'\t'
done

echo "$Tab" 'cd $P'
echo "$Tab" . '$*'

for((i=$#;i>=1;i--))
do
	Tab=${Tab:0:i-1}
	echo "$Tab" done	
done



