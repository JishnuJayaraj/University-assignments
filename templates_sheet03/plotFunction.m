% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function plotFunction(f_handle, lowerBounds, upperBounds, gridSize)
%
% *********
% * INPUT *
% *********
% f_handle     : Function mapping R^2->R.
% lowerBounds  : lower bounds for x in R^2.
% upperBounds  : upper bounds for x in R^2.
% gridSize     : grid gets a resolution of gridSize x gridSize.
%
% **********
% * OUTPUT *
% **********
%
%
% ***************
% * DESCRIPTION *
% ***************
% Draw surface and contour of function R^2 -> R in the given bounds.
%


% create the mesh
x_1 = linspace(lowerBounds(1),upperBounds(1),gridSize);
x_2 = linspace(lowerBounds(2),upperBounds(2),gridSize);
[X_1,X_2] = meshgrid(x_1,x_2);


% Evaluate the function at each grid point
F = zeros(gridSize);

for i = 1:gridSize
    for j= 1:gridSize
        F(i,j) = getValue(f_handle, [X_1(i,j); X_2(i,j)]);
    end
end


% Plot surface and contour
surf(X_1, X_2, F);

end

