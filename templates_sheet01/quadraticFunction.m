% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function [f,grad_f, hessian_f] = quadraticFunction(X)
%
% *********
% * INPUT * 
% ********* 
% X        : Column vector in R^2. 
% **********
% * OUTPUT *
% **********
% f        : function value.
% grad_f   : function gradient as column vector.
% hessian_f: function hessian.
%
% ***************
% * DESCRIPTION *
% *************** 
% Test function mapping from R^2 to R.
%

try
    x1=X(1,1);
    x2=X(2,1);
catch ME
    error('quadraticFunction:input','Input must be a 2x1 column vector!');
end

f=100*(x2-x1)^2 +2;

% Compute gradient only if requested
if nargout > 1
    grad_f (1,1) = -200*(x2-x1);
    grad_f (2,1) = 200*(x2-x1);
end

% Compute hessian only if requested
if nargout > 2
    hessian_f (1,1) = 200;
    hessian_f (2,1) = -200;
    hessian_f (1,2) = -200;
    hessian_f (2,2) = 200;
end


end


