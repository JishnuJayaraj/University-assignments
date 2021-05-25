% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function x_s = projectedNewton(f_handle, x_0, P_handle, eps, k_max)
%
% *********
% * INPUT *
% *********
% f_handle     : function handle with gradient evaluation.
% x_0          : start vector, column.
% P_handle     : projection mapping x into a set of box constraints
% eps          : tolerance.
% k_max        : maximum number of iterations.
%
% **********
% * OUTPUT *
% **********
% x_s      : local minimal point.
%
% ***************
% * DESCRIPTION *
% ***************
% Minimization using reduced Hessian and box constraints.
%

% check parameters
if nargin < 4
    eps=1.d-6;
end

if nargin < 5
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

% problem dimension
n = length(x_0);

% set starting point
x_k = getProjectedPoint(P_handle, x_0) ;

% initialize unit matrix used for reduction
E = eye(n) ;


% descent loop, use projection termination criterion 
while(norm(x_k - getProjectedPoint(P_handle, x_k - getGradient(f_handle,x_k)) ) && k < k_max)
    
    % extract active index set at x_k using P_handle
    A = getActiveIndexSet(P_handle, x_k) ;
       
    % reduce Hessian using active index set A_k
    B = getHessian(f_handle, x_k) ;
    
    for i = A
        B(:,i) = E(:,i) ;
        B(i,:) = E(i,:) ;
    end
    
    % descent direction as solution of hessian_k * d_k = -gradient_k
    % use conjugateGradient(A,b);
    
    d_k = conjugateGradient(B,- getGradient(f_handle,x_k) ) ;
    
    % check for descent direction, else use steepest descent as descent
    % direction
    if(getGradient(f_handle, x_k)' * d_k >= 0)
        d_k = - getGradient(f_handle,x_k) ;
    end
    
    % for line search call projectedBacktracking
    t_k = projectedBacktracking(f_handle, x_k, d_k, P_handle);
    
    % update current point using projection
    x_k = getProjectedPoint(P_handle, x_k + t_k*d_k) ;
    
    k = k+1;
end

x_s = x_k;

%%%%%%%%%%%%%%%%%%%%%%%%%%
% END OF MISSING CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%

end
