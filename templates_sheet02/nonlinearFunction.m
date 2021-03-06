% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function [f, gradf, hessian] = nonlinearFunction(X)
%
% *********
% * INPUT *
% *********
% X        : vector in R^2.
% **********
% * OUTPUT *
% **********
% f        : function value.
% gradf    : function gradient.
% hessian  : function hessian.
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
    error('rosenbrockFunction:input','Input must be a 2x1 column vector!');
end

f = -0.03/((x1 +0.25)^2 +(x2 -0.2)^2 +0.03) -0.1/((x1 -0.25)^2 +(x2 + 0.2)^2 +0.04) + 0.1/(x1^2 +x2^2 +0.05) +1 +x1^2 +x2^2 + 1;

% Compute gradient only if requested
if nargout > 1
    gradf(1,1) = 2*(x1 +0.25)*0.03/((x1 +0.25)^2 +(x2 -0.2)^2 +0.03)^2 +2*(x1 -0.25)*0.1/((x1 -0.25)^2 +(x2 + 0.2)^2 +0.04)^2 -2*x1*0.1/(x1^2 +x2^2 +0.05)^2 +2*x1;
    gradf(2,1) = 2*(x2 -0.2)*0.03/((x1 +0.25)^2 +(x2 -0.2)^2 +0.03)^2 +2*(x2 +0.2)*0.1/((x1 -0.25)^2 +(x2 + 0.2)^2 +0.04)^2 -2*x2*0.1/(x1^2 +x2^2 +0.05)^2 +2*x2;
end

% Compute hessian only if requested
if nargout > 2
    hessian = [ -.6e-1/((x1+.25)^2+(x2-.2)^2+.3e-1)^3*(2*x1+.50)^2+.6e-1/((x1+.25)^2+(x2-.2)^2+.3e-1)^2-.2/((x1-.25)^2+(x2+.2)^2+.4e-1)^3*(2*x1-.50)^2+.2/((x1-.25)^2+(x2+.2)^2+.4e-1)^2+.8/(x1^2+x2^2+.5e-1)^3*x1^2-.2/(x1^2+x2^2+.5e-1)^2+2, -.6e-1/((x1+.25)^2+(x2-.2)^2+.3e-1)^3*(2*x1+.50)*(2*x2-.4)-.2/((x1-.25)^2+(x2+.2)^2+.4e-1)^3*(2*x1-.50)*(2*x2+.4)+.8/(x1^2+x2^2+.5e-1)^3*x1*x2;
        -.6e-1/((x1+.25)^2+(x2-.2)^2+.3e-1)^3*(2*x1+.50)*(2*x2-.4)-.2/((x1-.25)^2+(x2+.2)^2+.4e-1)^3*(2*x1-.50)*(2*x2+.4)+.8/(x1^2+x2^2+.5e-1)^3*x1*x2,   -.6e-1/((x1+.25)^2+(x2-.2)^2+.3e-1)^3*(2*x2-.4)^2+.6e-1/((x1+.25)^2+(x2-.2)^2+.3e-1)^2-.2/((x1-.25)^2+(x2+.2)^2+.4e-1)^3*(2*x2+.4)^2+.2/((x1-.25)^2+(x2+.2)^2+.4e-1)^2+.8/(x1^2+x2^2+.5e-1)^3*x2^2-.2/(x1^2+x2^2+.5e-1)^2+2];
end

end

