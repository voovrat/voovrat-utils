generate_iteration_script creates the iteration script which implements multiple-fold iteration over the iterators given in separate files

Usage:  ./generate_iteration_script [list_file1 list_file2 ... ] > iter.sh

list_file1... list_fileN are the one-colums files which contain the values of the iterators.
The names of the iterators are the same as the names of the files without extention.


The resulting script iter.sh is the bash script which reads the data from the list_file1, list_file2,... and implement explicit multiple-fold for over the values in these files.
The resulting scipt take one or more arguments.
The first argument is the script name  which will be run for each combination of the iterators.
Other argumnts are arguments of the script.
The local variables with the names which coincide with the names of the lists will be set.

Please find below the example of using the script:

echo 1 2 3 > a.list
echo a b c > b.list
echo X Y Z > c.list

echo 'echo iterators=$a$b$c, Nargs=$# arguments=$1 $2 $3' > script.sh

./generate_iteration_script.sh a.list b.list c.list > iter.sh
./iter.sh script.sh  Arg1 Arg2 Arg3 

