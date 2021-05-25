% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function [t_s] = projectedBacktracking(f_handle, x_k, d_k, P_handle, sigma, beta)
%
% *********
% * INPUT *
% *********
% f_handle          : function handle with gradient evaluation.
% x_k, d_k          : current point and descent direction.
% P_handle 			: a mapping from R^n into the feasible set Omega
% sigma, beta       : step reduction and error tolerance.
%
% **********
% * OUTPUT *
% **********
% t_s         : local minimizing step length.
%
% ***************
% * DESCRIPTION *
% ***************
% backtracking line search for finding minimizing step length with projection.
%


%check arguments
if nargin < 5
    sigma=10e-4;
end
if nargin < 6
    beta=0.5;
end

%initialize data
j = 0;
j_max = 1000;
t_j = 1;

%check size of d_k and x_k
if size(x_k) ~= size(d_k)
    error('Error: x_k and d_k must have same dimension!');
end
%check if beta is in range
if(beta <= 0 || beta >= 1)
    error('Error: beta is out of range!');
end
%check if sigma is in range
if(sigma <= 0 || sigma >= 1)
    error('Error: sigma is out of range!');
end
%check if d_k is a descent direction
f_k = getValue(f_handle, x_k);
grad_k = getGradient(f_handle, x_k);
if(grad_k' * d_k >= 0)
    error('Error: d_k is not a descent direction!');
end


%reduce to 1D problem with anonymous function
phi=@(t)f_handle(getProjectedPoint(P_handle, x_k + t * d_k));
while (phi(t_j) > f_k - sigma/t_j * norm(x_k - getProjectedPoint(P_handle, x_k + t_j * d_k))^2 && j<j_max)
    t_j = t_j * beta;
    j = j+1;
end

t_s = t_j;
if (j==j_max)
	warning('Warning max number of iterations reached!'); %TODO
end


end



