% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function activeIndexSet = getActiveIndexSet(p_handle, x)
%
% *********
% * INPUT *
% *********
% p_handle 			: projection handle mapping x into a set of box constraints with active index set evaluation..
% x 	      		: point to map.
%
% **********
% * OUTPUT *
% **********
% activeIndexSet	: active set of the projection as a row vector of indices.
%
% ***************
% * DESCRIPTION *
% ***************
% Returns the active index set of the projection of x with p_handle 

[dummy, activeIndexSet] = p_handle(x);

end
