## Copyright (C) 2016 volodymyr.sergiievsk
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} readspk (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: volodymyr.sergiievsk <volodymyr.sergiievsk@NB-SERGIIEVSKYI>
## Created: 2016-10-10

function [X,Y] = readspk (fname)

[X,Y] = textread(fname,'%f\t%f','delimiter','\n');
N = sum( ~isnan(Y));
X = X(1:N); Y=Y(1:N);


endfunction
