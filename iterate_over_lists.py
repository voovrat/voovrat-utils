# by Volodymyr P Sergiievskyi aka voov.rat (voov.rat@gmail.com)

from os import system

# Iterate over multiple iterators specified as a python lists
# variables: names of the iterators
# lists: the values of the iterators 
# fn is a function which takes one argument (data)
# fn_param : orbitrary function params. Dictonary which will contain additional data available for the iteration function
def iterate_over_lists(variables,lists,fn,fn_param={}):
	sub_iterate_over_lists(variables,lists,fn,0,fn_param)

# level is a current level of list iteration (0 - top level, N-1 - lowest (elementary)
# data - currently filled data array
def sub_iterate_over_lists(variables,lists,fn,level,data):
	N=len(lists);
	if(level==N):
		fn(data)
	else:
		for i in lists[level]:
			data[variables[level]]=i;
			sub_iterate_over_lists(variables,lists,fn,level+1,data);

# Runs a bash script with parameters contained in data dictionary
# The script name is specified in 'script_file' key of dictionary
# The optional path to script is specified in 'path' key 
# Other keys are passed to the script as local variables
def run_script(data):
	cmd='';
	for key in data.keys():
		cmd=cmd+key+'='+str(data[key])+';'; 	
	if 'path' in data:
		path = data['path'];
	else:
		path='.';

	cmd=cmd+'. '+path+'/'+data['script_file'];
#	print(cmd);
	system(cmd)

# ############ HOW TO USE ###########################

if __name__ == "__main__":

#### EXAMPLE #1: python interface:

# Step 1: define a pyhton function with one parameter data
#	  data is a dictionary which will contain the values of iterators
#         we can also store there non-changable parameters of functions
	def f(data):
		f.cnt+=1;
		print('-------------------------');
		print('Function call #'+str(f.cnt));
		print('Parameters:');
		print(' * 1st_non_iterable_argument:'+str(data['first_non_iterable_argument']));
		print(' * 2nd_non_iterable_argument:'+str(data['second_non_iterable_argument']));
		print(' * 1st_iterator:'+str(data['first_iterator']));
		print(' * 2nd_iterator:'+str(data['second_iterator']));
		print(' * 3rd_iterator:'+str(data['third_iterator']));
	f.cnt=0;


#		print(data);
	

# Step 2: Define lists of variables (values of the iterators)
	lists={};
	variables={};
	
	variables[0]='first_iterator';
	lists[0] = [1,2,3];

	variables[1]='second_iterator';
	lists[1] = ['a','b'];

	variables[2]='third_iterator';
	lists[2] = ['X','Y'];

# Step 3: Run iterate over lists function
# 	first argument - names of the iterators (variables)
# 	second argument - values of the iterators (lists)
#	third argument - the function (f in this example)
#	the last argument - the dictionary which contains additional arguments for the f function
	print('############ simple example with non-iterable arguments');

	iterate_over_lists(variables,lists,f,{'first_non_iterable_argument':'Hello','second_non_iterable_argument':'World'})


# EXAMPLE 2: RUNNING A BASH SCRIPT

	print('########## running bash script example');

# Step 1: Create a bash script. The iterators will be available in the script as local variables.
# 	we can also pass some additional arguments to the scripts which will be also available as local bash variables

	f=open('example.sh','w');
	f.write('#!/bin/bash\n');
	f.write('echo "---------- This runs from bash"\n');
	f.write('echo "The following local variables are available:"\n');
	f.write('echo "* first_iterator="$first_iterator\n');
	f.write('echo "* second_iterator="$second_iterator\n');
	f.write('echo "* third_iterator="$third_iterator\n');
	f.write('echo "* some_script_param="$some_script_param\n');
	f.write('echo "* other_script_param="$other_script_param\n');
	f.close();

#Step 2: run iterate over lists
#	 the arguments are the same as in previous example
#        third_argument is run_script function
#	 the last argument contain the additional data which will be passed to the bash script in the form of local variables
	iterate_over_lists(variables,lists,run_script,{'script_file':'example.sh','some_script_param':'"Some Data"','other_script_param':'"Other Data"'})




