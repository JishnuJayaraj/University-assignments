% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function [R, J] = errorFunction(x)

%
% *********
% * INPUT *
% *********
% x           : vector in R^2.
%
% **********
% * OUTPUT *
% **********
% R           : returns error vector in R^(2 x 1).
% J           : returns Jacobian of R in R^(2 x 2).
%
% ***************
% * DESCRIPTION *
% ***************
% Least squares error vector and Jacobian
% evaluation.
%
try
	u=x(1);
	v=x(2);
catch ME
    error('errorFunction:args','args are wrong');
end

R = [cos(u); sin(2*u)];
J = [-sin(u), 0; 2*cos(2*u), 0];

end

