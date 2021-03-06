% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function [t_s] = bisectionLineSearch(f_handle, x_k, d_k, eps, k_max)
%
% *********
% * INPUT *
% *********
% f_handle : function handle R^n -> R.
% x_k, d_k : current point and descent direction.
% eps      : tolerance.
% k_max    : maximum number of iterations.
%
% **********
% * OUTPUT *
% **********
% t_s        : optimal step size.
%
% ***************
% * DESCRIPTION *
% ***************
% Bisection line search for finding minimizing step length.
%

%check arguments
if nargin < 4
    eps = 1.0e-6;
end

if nargin < 5
    k_max = 1000; % counter for maximal number of iterations.
end

if(eps <= 0)
	error('Error: eps has to be greater 0');
end

%check size of d_k and x_k
if size(x_k) ~= size(d_k)
    error('Error: x_k and d_k must have same dimension!');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
% START OF MISSING CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%

%initialize variables
k = 0; %count iteration
t_l = 0 ;                                                 %setting time
t_r = 1 ;
dt = abs(t_l - t_r) ;

    phi_l = (getValue(f_handle,x_k) )  ;
    phi_r = (getValue(f_handle,x_k + d_k) )  ;
    
%do binary line search loop, k < k_max is required
while ( dt >  eps && k < k_max)
    
    
    
    
    if (phi_l <= phi_r  )
        t_r = (t_r + t_l)/2;
        phi_r = getValue(f_handle,x_k + t_r*d_k)   ;               % 
        
    else
        t_l = (t_r + t_l)/2;
        phi_l = getValue(f_handle,x_k + t_l*d_k)   ;
    end
    
    k = k+1;
    dt = abs(t_l - t_r) ;
end

%return step size
if (phi_l < phi_r)
    t_s = t_l ;
else
    t_s = t_r ;
end

if t_s == 0
    warning('bisection line search failed, step size is zero!');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
% END OF MISSING CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%

end

