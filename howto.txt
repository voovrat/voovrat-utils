The file iterate_over_lists.py provides the basic interface for iterate over multiple iterators specified in the pyhton list variables.

To use the interface you can use the command:

from iterate_over_lists import *

the main function in the file is iterate_over_lists.
Please find below the description of this function:

def iterate_over_lists(variables,lists,fn,fn_param={})

Here meaning of the parameters is the following: 
	variables:	names of the iterators
	lists: 		the values of the iterators 
	fn: 		the function which takes one argument (data)
	fn_param: 	arbitrary function params. Dictonary which will contain additional data available for the iteration function

the function fn will be called for all combinations of the iterator values from the lists.
The values of the iteratiors are passed to the function fn using the dictionary data.
The keys of the dictionary are the same as the variables parameter passed to the iterate_over_lists function.
Also, additional parameters will be set in the data dictionary to be the same as fn_params.

EXAMPLE of iterate_over_lists function:

#### EXAMPLE #1: python interface:

from iteratr_over_lists import *

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

-------------------------------------------------------------------------

Also in some cases it is necessary to run the specific bash script for the all posible values of the iterators.
To do this one can also use the iterate_over_lists function.
I created special function which can be passed to it - run_script function.

Please find below the description of this function:

def run_script(data)

The function runs a bash script with parameters contained in data dictionary
The script name is specified in 'script_file' key of dictionary
The optional path to script is specified in 'path' key 
Other keys are passed to the script as local variables

Please find below the example of using this script 
( do not forget to put the line 
 from iterate_over_lists import * 
in the beginning of your python script)

# EXAMPLE 2: RUNNING A BASH SCRIPT

	print('########## running bash script example');

# Step 1: Create a bash script. The iterators will be available in the script as local variables.
# 	we can also pass some additional arguments to the scripts which will be also available as local bash variables

Create the file example.sh with the following content:


#!/bin/bash
echo "---------- This runs from bash"
echo "The following local variables are available:"
echo "* first_iterator="$first_iterator
echo "* second_iterator="$second_iterator
echo "* third_iterator="$third_iterator
echo "* some_script_param="$some_script_param
echo "* other_script_param="$other_script_param

#Step 2 : create the python file 

	from iterate_over_lists import *

	lists={};
	variables={};
	
	variables[0]='first_iterator';
	lists[0] = [1,2,3];

	variables[1]='second_iterator';
	lists[1] = ['a','b'];

	variables[2]='third_iterator';
	lists[2] = ['X','Y'];

	iterate_over_lists(variables,lists,run_script,{'script_file':'example.sh','some_script_param':'"Some Data"','other_script_param':'"Other Data"'})


#	 the arguments of the iterate_over_lists are the same as in previous example
#        third_argument is run_script function
#	 the last argument contain the additional data which will be passed to the bash script in the form of local variables




