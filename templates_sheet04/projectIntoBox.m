% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function [P, A] = projectIntoBox(x, a, b, eps)
%
% *********
% * INPUT *
% *********
% x           : vector in R^n.
% a           : lower bounds vector in R^n.
% b           : upper bounds vector in R^n.
% eps         : for epsilon-active sets
%
% **********
% * OUTPUT *
% **********
% P           : projected point in Omega.
% A           : (epsilon-)active set of p as a row vector of indices.
%
% ***************
% * DESCRIPTION *
% ***************
% Projects x into a set of box constraints and returns also the active set
% as a row vector of indices as second argument
%

% check arguments
if nargin < 4
    eps = 0;
end

n = length(x);

%check size of a, b
if (length(a)~=n || length(b)~=n)
    error('Error: x, a and b must have same dimension!');
end

if(eps < 0)
	error('Error: eps has to be greater or equal 0');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
% START OF MISSING CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%

% inititalize P in R^n and A as empty index set
P = x;
A = [];

for i=1:n %loop over all indexes
    %project whenever necessary
    %if x(i) is projected or in epsilon range of bounds, add i to A
    if(x(i) <= a(i))
        P(i) = a(i) ;
    end
    
    if(a(i) < x(i) && x(i) < b(i))
        P(i) = x(i) ;
    end
    
    if(x(i) >= b(i))
        P(i) = b(i) ;
    end
    
    if( x(i) <= a(i) + eps || x(i) >= b(i) - eps  )
        A = [A i] ;
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
% END OF MISSING CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%

end
