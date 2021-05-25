% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function [] = INTRO2018()

% Welcome to Optimization for Engineers in summer term 2018. This script
% will introduce you into the usage of Matlab. The functionalities are
% easier to understand, if the script is run in debug mode, so each line is
% executed separately.

%
% STARTING THE SCRIPT IN DEBUG MODE
%

% To start a script (or .m-file) you must be in the right path. In this
% case, INTRO2018.m must show up in the FILE BROWSER (<-left window). If
% not, you must browse to the folder containing the .m-file or by adding
% the containing folder and its sub folders to the path using the
% rightclick-context menu.

% A .m-file is runned by calling it in the COMMAND WINDOW (window below) or
% using the "Run"-Button in the EDITOR Tab above. The script is then
% executed in release mode, so you cannot execute line by line and have
% little insight in what is happening.

% We instead use the debug mode to execute the code line by line and
% observe the change of variables. To call a .m-file in debug mode, it is
% sufficient to set any break point at some executable line, like the
% following:

myString = 'This string is a breakable line';

% Now do the following: 1) Click the - in the left column (next to the line
% number) to set a breakpoint (red dot) in the line. 2) Run the script. 3)
% The script should run to the line with myString (green arrow at break
% point). 4) Use the "Step" button (see EDITOR tab above) at every
% executable line to go step by step through this script and observe the
% results.

%
% GOING STEP BY STEP
%

myString2 = 'The next step should lead you here!';

% The upper right window is the WORKSPACE. Here you see the previously
% defined string 'myString'. In debug mode, you can inspect objects by
% hovering over them with the mouse pointer in the EDITOR or by
% doubleclicking in the WORKSPACE.

% Now we demonstrate different commands necessary for the lab exercises.
% Please step through this section in debug mode line by line. For further
% information on single commands please use the Matlab documentation (press
% F1 or use the command 'help').

% First we clear the command window with 'clc' and the workspace with
% 'clear' (use "Step" button to do this now)

clc; %clear command window
clear; %clear workspace

% Now we define a matrix A:
A = [1 2 0; 3 4 7];

% And show it in the command window using display
display(A);

% But in debug mode we can directly hover over the variable or look into
% the workspace to see its values.

% We can access the entry in row 1, column 2...
myEntry = A(1,2); %see value in WORKSPACE
display(myEntry);

% Or the first row...
myRow = A(1,:);
display(myRow);

% Or the second column...
myColumn = A(:,2);
display(myColumn);

clear;

%
% LINEAR ALGEBRA CODE EXAMPLES
%

% A vector is treated by Matlab as a 1xn matrix
x1 = [1 2 3 2 1];
display(x1);

% Equidistant vectors can be generated using the notation
% startValue:step:endValue (Hint: startValue:endValue is short for
% startValue:1:endValue)
x2 = 1:1:5;
display(x2);

% Linear algebra is already implemented in Matlab
myVector = x1 + 2;
display(myVector);

% Vectors of zeros and ones are easy to initialize
otherVector = 2*ones(1,5);
display(otherVector);

bothVectors = myVector + otherVector;
display(bothVectors);

% We can transpose a vector or matrix with '
columnVector=myVector';
display(columnVector);

scalarProduct = columnVector'*columnVector;
display(scalarProduct);

innerProduct = columnVector*columnVector';
display(innerProduct);

matrixTimesVector = innerProduct*columnVector;
display(matrixTimesVector);

% Hover over these variables before clearing to see their values

clear;
%
% FOR WHILE IF ELSE CODE EXAMPLES
%

% Here is an example for the syntax of control statements
myBool = true;

while (myBool)
    for i=1:3
        if (i == 1 || ~myBool) %~ is 'not' in Matlab
            disp('"if" branch');
        elseif (i > 1 && i < 3)
            disp('"elseif" branch');
        else
            disp('"else" branch');
        end %end "if-else" tree
    end %end "for" loop
    myBool=~myBool; %change bool sign
end %end "while" loop

%
% FUNCTION CODE EXAMPLES
%

% Basic math functions are already implemented in matlab.

myAngle = sin(pi/2);
display(myAngle);

% For the lab exercises we will complete functions in .m-file templates.

% The syntax is always

% function [outputArguments] = functionName (inputArguments)
%       do something with the inputArguments to set the outputArguments
% end

% Matlab does not check the type of your input arguments for correctness.
% For example, the function eig(A) computes the eigenvectors and
% eigenvalues of a quadratic matrix A.

try
    A = [1 2;2 1]; %quadratic
    B = [1 2;2 1; 1 1]; %nonquadratic
    
    [eigVects, eigVals] = eig(A); %this works
    display(eigVects);
    display(eigVals);
    
    [eigVects2, eigVals2] = eig(B); %this does not work
    display(eigVects2);
    display(eigVals2);
    
catch errorMessage
    disp(errorMessage)
end

clear;

% A very important feature is the definition of a local, anonymous
% function, which is often needed in this lab exercise. The syntax is

anonymousFunctionName = @(inputArguments) expression;

% Example for a rotation matrix:

rotationMatrix = @(angle) [cos(angle) sin(angle);-sin(angle) cos(angle)];

% Displaying "rotationMatrix" without arguments shows us, that it is a handle
% (pointer) to the anonymous function.

display(rotationMatrix);

% We can generate the value of the anonymous function using getValue()
myAngle = pi/2;
rotationWithMyAngle = getValue(rotationMatrix,myAngle);
display(rotationWithMyAngle);

% Functions that are defined in .m-files can be evaluated using function handles, too.
% rosenbrockFunction.m is a 2-dimensional test function and can be accessed
% in code using the following function handle:

f_handle = @rosenbrockFunction;
display(f_handle);

x_k=[1;3];
display(x_k);

f_k=getValue(f_handle,x_k);
display(f_k);

clear;
% Function handles are needed as input arguments in optimization!

% Matlab also features various visualization tools. The following code
% generates a figure. The figure opens in a separate window. It is helpful
% to dock the figure to this window using the "dock" button (small arrow in
% the upper right of the figure window).

t = 0:pi/50:10*pi;
plot3(sin(t),cos(t),t);

disp('This ends the introduction script.');
disp('Try now to start the sheet00Script.m by calling "sheet00Script(1)" in the command window.');
disp('You can use the tab key for autocompleting the call.');
end

