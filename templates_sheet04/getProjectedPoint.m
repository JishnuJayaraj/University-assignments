% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function projectedPoint = getProjectedPoint(p_handle, x)
%
% *********
% * INPUT *
% *********
% p_handle 			: projection handle mapping x into a set of box constraints.
% x 	      		: point to map.
%
% **********
% * OUTPUT *
% **********
% projectedPoint	: projection of x.
%
% ***************
% * DESCRIPTION *
% ***************
% Calculates the projection of a given point x according to the given p_handle.
%

projectedPoint = p_handle(x);

end
