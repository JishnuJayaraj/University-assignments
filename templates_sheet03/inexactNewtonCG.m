% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function [x_s] = inexactNewtonCG(f_handle, x_0, eps, k_max, verbose)
%
% *********
% * INPUT *
% *********
% f_handle : function handle with gradient evaluation.
% x_0      : start vector, column.
% eps      : tolerance.
% k_max    : max. number of iterations.
% verbose  : set to true, if all feedback should be printed.
%
% **********
% * OUTPUT *
% **********
% x_s      : local minimal point.
%
% ***************
% * DESCRIPTION *
% ***************
% Minimization using CGDirection.
%


% check parameters
if nargin < 3
    eps = 1.d-6;
end
if(eps <= 0)
	error('Error: eps has to be greater 0');
end

if nargin < 4
    k_max = 100;
end

if nargin < 5
    verbose = false;
end

%initialize data
k = 0;
x_k = x_0;
h = eps / 1000;


% store current objective, gradient and hessian
f_k = getValue(f_handle, x_k);
grad_k = getGradient(f_handle, x_k);

% descent loop
while(norm(grad_k) > eps && k < k_max)

    % descent direction as approximated solution of hessian_k * d_k = -grad_k
    d_k = CGDirection(f_handle, x_k, h, verbose);

    % check for descent direction
    if(grad_k' * d_k >= 0)
        error('d_k is not a descent direction!');
    end
    
    % line search
    t_k = backtrackingLineSearch(f_handle, x_k, d_k);    
       
    % update current point
    x_k = x_k + t_k * d_k;
    
    % update current objective, gradient and hessian
	f_k = getValue(f_handle, x_k);
	grad_k = getGradient(f_handle, x_k);
    
    k = k+1;
end

x_s = x_k;

end
