% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function [t_s] = backtrackingLineSearch(f_handle, x_k, d_k, sigma, beta, j_max)
%
% *********
% * INPUT *
% *********
% f_handle    : function handle with gradient evaluation.
% x_k, d_k    : current point and descent direction.
% sigma, beta : step reduction and error tolerance.
% j_max       : maximum number of iterations.
%
% **********
% * OUTPUT *
% **********
% t_s         : local minimizing step length.
%
% ***************
% * DESCRIPTION *
% ***************
% Backtracking line search for finding minimizing step length.
%

%check arguments
if nargin < 4
    sigma=1.0e-4;
end

if nargin < 5
    beta=0.5;
end

if nargin < 6
    j_max=100;
end


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

%initialize useful variables holding constant values
j = 0;
t_j = 1;
f_k = getValue(f_handle, x_k);
grad_k = getGradient(f_handle, x_k);
grad_k_d_k=grad_k' * d_k;
sigma_grad_k_d_k = sigma * grad_k_d_k;

%check if dk is a descent direction
if(grad_k_d_k >= 0)
    error('My Personal Error: d_k is not a descent direction!');
end

%calculates function value at position x_k + t*d_k
phi=@(t)getValue(f_handle, x_k + t * d_k); 

%loop for finding step size, j < j_max is required
while (phi(t_j) > f_k + t_j * sigma_grad_k_d_k && j < j_max) 
    t_j = t_j * beta;
    j = j+1;
end

t_s = t_j;

end

