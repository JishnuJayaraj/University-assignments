% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function [x_s] = levMarq(error_handle, x_0, eps, alpha_0, beta, k_max)
%
% *********
% * INPUT *
% *********
% error_handle  : function handle with error vector and Jacobian evaluation.
% x_0           : start vector, column.
% eps           : tolerance.
% alpha_0       : starting value for damping.
% beta          : adapting factor for alpha
% **********
% * OUTPUT *
% **********
% x_s        	: local minimal point.
%
% ***************
% * DESCRIPTION *
% ***************
% Minimization using Levenberg-Marquardt.
%

% check parameters
if nargin < 3
    eps = 1.d-6;
end
if nargin < 4
    alpha_0 = eps;
end
if nargin < 5
    beta = 100;
end
if nargin < 6
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
n = length(x_0);

x_k = x_0 ;
alpha_j = alpha_0 ;

% GENERAL CODING ADVICE: Use anonymous functions in this code.
% for example if the following line is defined before the loop:
%
% R = @(y)getErrorVector(error_handle,y)
%
% calling
%
% R(x_k) 
%
% inside the loop is an abbreviation for 
%
% getErrorVector(error_handle,x_k)

% store current objective, gradient and hessian

R = @(y)getErrorVector(error_handle,y) ;
J = @(y)getErrorJacobian(error_handle,y) ;

R_k = R(x_k) ;
J_k = J(x_k) ;

% f_handle = 0.5 * R(x_k)' * R(x_k) ;
gradf = J(x_k)' * R(x_k);
 
% descent loop
while(norm(gradf) > eps && k < k_max)
    
    f_handle = 0.5 * R(x_k)' * R(x_k) ;
    gradf = J(x_k)' * R(x_k);
    
    % descent direction as solution of [J_k' * J_k + alpha_j * eye(n)] * d_k = -grad f_k
    % use conjugateGradient to get d_k.
   
    b = -gradf ;
    
    d_k = conjugateGradient(J_k' * J_k + alpha_j * eye(n), b);
    
    f_handlenew = 0.5 * R(x_k + d_k)' * R(x_k + d_k) ;
    
    if (f_handlenew < f_handle)
                
        % update values for next loop run
       x_k = x_k + d_k ;
       alpha_j = alpha_0 ; 
        k = k+1;
    else
        alpha_j = beta * alpha_j ;
    end
    R_k = R(x_k) ;
    J_k = J(x_k) ;
end

x_s = x_k ;

%%%%%%%%%%%%%%%%%%%%%%%%%%
% END OF MISSING CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%

end
