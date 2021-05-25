% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function hessian = getHessian(f_handle, x)
%
% *********
% * INPUT *
% *********
% f_handle    : function handle with hessian evaluation.
% x 	      : point for hessian evaluation.
%
% **********
% * OUTPUT *
% **********
% hessian    : hessian at position x.
%
% ***************
% * DESCRIPTION *
% ***************
% Calculates hessian of f_handle at a given position x.
%

[dummy1, dummy2, hessian] = f_handle(x);

end
