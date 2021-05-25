% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function errorVector = getErrorVector(error_handle, x)
%
% *********
% * INPUT *
% *********
% error_handle 	: function handle.
% x 	      	: point for function evaluation.
%
% **********
% * OUTPUT *
% **********
% errorVector	: Jacobian at position x.
%
% ***************
% * DESCRIPTION *
% ***************
% Calculates the functionValue of error_handle at a given position x.
%

errorVector = error_handle(x);

end
