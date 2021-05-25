% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function [R, J] = spiralFitting(x, draw, color)

%
% *********
% * INPUT *
% *********
% x           : vector in R^4.
% draw        : draw option
% color       : option for multiple function plots
%
% **********
% * OUTPUT *
% **********
% R           : returns error vector in R^(m x 1).
% J           : returns Jacobian of R in R^(m x 4).
%
% ***************
% * DESCRIPTION *
% ***************
% Least squares error vector and Jacobian
% evaluation. The curve S: t-> [x(1)*cos(x(2)*t;x(3)*sin(x(4)*t] should fit
% to data points t->[Y(t),Z(t)].
%

% check arguments
if nargin < 2
    draw=0;
end
if nargin < 3
    color='green';
end

% data is loaded from spiralFittingData.mat
load 'spiralFittingData.mat';

% extract columns
T=spiralFittingData(:,1);
Y=spiralFittingData(:,2);
Z=spiralFittingData(:,3);

% problem dimensions
n = length(x);
m = length(T);

% initialize first m components of the error vector being the distance
% between y-components of spiral S and y-components of data points.
R1=zeros(m,1);
J1=zeros(m,n);

% initialize second m components of the error vector being the distance
% between z-components of spiral S and z-components of data points.
R2=zeros(m,1);
J2=zeros(m,n);

%loop for filling R and J
for j=1:m
    %first components of R
    R1(j)=x(1)*cos(x(2)*T(j))-Y(j);
    %second components of R
    R2(j)=x(3)*sin(x(4)*T(j))-Z(j);
    
    %first matrix entries of J
    J1(j,1)= cos(x(2)*T(j));
    J1(j,2)= -x(1)*sin(x(2)*T(j))*T(j);
    J1(j,3)= 0;
    J1(j,4)= 0;
    
    %second matrix entries of J
    J2(j,1)= 0;
    J2(j,2)= 0;
    J2(j,3)= sin(x(4)*T(j));
    J2(j,4)= x(3)*cos(x(4)*T(j))*T(j);
end

%compose and scale both parts
R=[R1;R2]/10;
J=[J1;J2]/10;

%draw options
if draw
    YS=@(t)(x(1)*cos(x(2)*t));
    ZS=@(t)(x(3)*sin(x(4)*t));
    
    hold on
    grid on
    plot3(YS(T),ZS(T),T,'color', color, 'linewidth', 2);
    plot3(Y(1:m),Z(1:m),T,'color', 'blue', 'linewidth', 2);
    for j=1:m
        plot3([YS(T(j));Y(j)],[ZS(T(j));Z(j)],[T(j);T(j)],'-','color', 'red', 'linewidth', 1);
    end
    hold off
end

end

