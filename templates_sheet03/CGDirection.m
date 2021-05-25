% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function [d_k] = CGDirection(f_handle, x_k, h, verbose)
%
% *********
% * INPUT *
% *********
% f_handle : function handle with gradient evaluation.
% x_k      : point to construct the direction for.
% h		   : weighting factor for hessian*d approximation.
% verbose  : set to true, if all feedback should be printed.
%
% **********
% * OUTPUT *
% **********
%
% ***************
% * DESCRIPTION *
% ***************
% Calculating descent direction for Inexact-Newton-CG.
%

%initialize data
if nargin < 4
    verbose = false;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%
% START OF MISSING CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%

n = length(x_k);

x_j = zeros(n,1) ;
d_j = -getGradient(f_handle, x_k);

if (norm(d_j) == 0)
    error('Gradient is zero.');
end

if (length(d_j) ~= length(x_j))
    error('Dimensions do not match.');
end

r_j = getGradient(f_handle, x_k);
eta_k = min( 0.5 , norm( getGradient(f_handle, x_k) ) );

for j=1:n
    
    % start with the approximated Hessian depending on x_k, h and d_j
    if (norm(d_j) < h)
        hessian = 0; 
    else
        hessian = (norm(d_j)/h) * ( getGradient(f_handle, x_k+(h/norm(d_j)*d_j))-getGradient(f_handle, x_k) ) ; 
    end
       
   
       
       rho_j = d_j' * hessian ;
       
    % check curvature information
    if (rho_j <= 0)
        % using return here:
        % first define the return argument 'd_k', then 'return' is called to break the current loop
        if(j == 1)
            d_k = d_j;
            if (verbose) 
                disp('negative curvature, d_k is set to steepest descent'); 
            end
        else
            d_k = x_j;
            if (verbose)
                disp('negative curvature, d_k consists of conjugate directions');
            end
        end
        
        return
    end
    
    t_j = -(r_j' * d_j)/rho_j;
    x_j = x_j + t_j*d_j ;
    r_j = r_j + t_j*hessian ;
    
    % accept current d_k, if ||r_j|| is small enough
    if (norm(r_j) < eta_k * norm(getGradient(f_handle, x_k)))
        d_k = x_j;
        if (verbose)
            fprintf('d_%d satisfies inexact Newton inequality\n',j);
        end
        return
    end
    
    beta_j = (r_j'*hessian)/(rho_j);
    % update d_j
    d_j = -r_j + beta_j * d_j ;
end

d_k = x_j;
warning('CGDirection did not converge properly!');

%%%%%%%%%%%%%%%%%%%%%%%%%%
% END OF MISSING CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%

end

