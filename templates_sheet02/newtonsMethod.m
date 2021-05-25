% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function [x_s] = newtonsMethod(f_handle, x_0, eps, k_max)
%
% *********
% * INPUT *
% *********
% f_handle : function handle with gradient and hessian evaluation.
% x_0      : start vector, column.
% eps      : tolerance.
% k_max    : maximum number of iterations.
%
% **********
% * OUTPUT *
% **********
% x_s      : local minimal point.
%
% ***************
% * DESCRIPTION *
% ***************
% Minimization using steepest descent.
%

% check parameters
if nargin < 3
    eps=1.d-5;
end
if nargin < 4
    k_max = 100;
end
if(eps <= 0)
    error('Error: eps has to be greater 0');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
% START OF MISSING CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%

% initialize data
k = 0;

x_k = x_0;

% store current gradient and hessian
grad_k = getGradient(f_handle, x_k) ;
hessian_k = getHessian(f_handle,x_k);

% descent loop
while(norm(grad_k) > eps && k < k_max)
    
    % descent direction as solution of hessian_k * d_k = -grad_k
    d_k = conjugateGradient(hessian_k, -grad_k);
    
    % check for descent direction, if this is true, use backtracking
    if(grad_k' * d_k < 0)                                                              %
        t_k = backtrackingLineSearch(f_handle, x_k, d_k);
        
    else  %if descent direction check fails, throw warning and use steepest descent with bisection
        warning('d_k is not a descent direction');
        d_k =  -grad_k ;                                                        %
        t_k = bisectionLineSearch(f_handle, x_k, d_k);
    end
    
    % update current point
    x_k = x_k + t_k*d_k ;
    
    % update current gradient and hessian
    grad_k = getGradient(f_handle, x_k) ;
    hessian_k = getHessian(f_handle,x_k);
    
    k = k+1;
end

x_s = x_k;

%%%%%%%%%%%%%%%%%%%%%%%%%%
% END OF MISSING CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%
end
