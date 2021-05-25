% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function gradient = getGradient(f_handle, x)
%
% *********
% * INPUT *
% *********
% f_handle    : function handle with gradient evaluation.
% x 	      : point for gradient evaluation.
%
% **********
% * OUTPUT *
% **********
% gradient    : gradient at position x.
%
% ***************
% * DESCRIPTION *
% ***************
% Calculates gradient of f_handle at a given position x.
%

[dummy, gradient] = f_handle(x); %#ok<ASGLU>

end
