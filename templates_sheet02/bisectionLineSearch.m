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

%initialize data
k = 0;
t_l = 0;
t_r = 1;

%reduce to 1D problem with anonymous function
phi=@(t)getValue(f_handle, x_k + t * d_k); %calculates function value at position x_k + t * d_k
phi_l = phi(t_l);
phi_r = phi(t_r);


%do binary line search loop
while (abs(t_l - t_r) > eps && k < k_max)
    
    if (phi_l <= phi_r)
        t_r = 0.5 * (t_l + t_r);
        phi_r = phi(t_r);
    else
        t_l = 0.5 * (t_l + t_r);
        phi_l = phi(t_l);
    end
    k = k+1;
end

%return step size
if (phi_l <= phi_r)
    t_s = t_l;
else
    t_s = t_r;
end

if t_s == 0
    warning('bisection line search failed, step size is zero!');
end
end

