% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function value = getValue(f_handle, x)
%
% *********
% * INPUT *
% *********
% f_handle     	: function handle.
% x 	      	: point for function evalutation.
%
% **********
% * OUTPUT *
% **********
% value    		: function value at position x.
%
% ***************
% * DESCRIPTION *
% ***************
% Calculates the function value at a given position x.
%

value = f_handle(x);

end
