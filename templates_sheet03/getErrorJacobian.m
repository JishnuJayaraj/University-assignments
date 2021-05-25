% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function errorJacobian = getErrorJacobian(error_handle, x)
%
% *********
% * INPUT *
% *********
% error_handle 	: function handle with Jacobian evaluation.
% x 	      	: point for Jacobian evalutation.
%
% **********
% * OUTPUT *
% **********
% errorJacobian	: Jacobian at position x.
%
% ***************
% * DESCRIPTION *
% ***************
% Calculates the Jacobian of error_handle at a given position x.
%

[dummy, errorJacobian] = error_handle(x);

end
