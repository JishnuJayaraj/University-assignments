% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function []=sheet02Script(n)

if nargin < 1
    disp('Please set assignment number as argument to test')
    return;
end

switch n
    
    case 1
        try
            A = [8 -1 5; -1 7 2; 5 2 7];
            b = [1;1;0];
            x_s1 = conjugateGradient(A, b);
            res = A * x_s1 - b;
            if (abs(res)>1.0e-5)
                error('conjugateGradient:result','wrong result');
            end

            disp('conjugateGradient.m seems to be correct.');			           
            disp('');
            disp('Initialize visualization...');
           
            A = [17 -1; -1 3.7];
            b = [1;0.2];
            x_0 = [1;1.2];
            
            quadraticFunctionHandle=@(X)0.5*X'*A*X-b'*X;
                        
            k=1;
            n=2;
            x_all = [x_0,zeros(2,2)];
            for k=1:n
                x_all(1:2,k+1) = conjugateGradient(A, b, x_0, 1e-5, k);
            end
            
            y_all = [x_0,zeros(2,7)];
            for k=1:7
                X=y_all(1:2,k);
                y_all(1:2,k+1) = X-(A*X-b)'*(A*X-b)/((A*X-b)'*A*(A*X-b))*(A*X-b);
            end
            
            clf            
            plotFunction(quadraticFunctionHandle,[-0.5;-0.5],[1.5,1.5],75);
            axis([-0.5,1.5,-0.5,1.5,-1.2,10]);
            view([-68,60]);
            hold on
            
            for k=1:n
                plot3([x_all(1,k),x_all(1,k+1)],[x_all(2,k),x_all(2,k+1)],[quadraticFunctionHandle(x_all(:,k)),quadraticFunctionHandle(x_all(:,k+1))],'r*-', 'linewidth', 2);
            end
            
            for k=1:7
             plot3([y_all(1,k),y_all(1,k+1)],[y_all(2,k),y_all(2,k+1)],[quadraticFunctionHandle(y_all(:,k)),quadraticFunctionHandle(y_all(:,k+1))],'g:', 'linewidth', 2);
            end
            
            title('Conjugate Gradient solves a quadratic problem using up to n conjugate directions. See command window for explanation.');         
            
            hold off
            
            disp('You should see the red conjugate gradient path, taking only two steps to converge.')
            disp('The green dotted zickzacking path is the Q-linearly converging steepest descent path.')
           
 
        catch ME
            disp('Error found in conjugateGradient.m');
            ME
        end
        
    case 2
        try
            x_0=[0;1];
            x_NL=[0.1;0.9];
            f_handle_NL=@nonlinearFunction;
            f_handle_RB=@rosenbrockFunction;
            x_s1 = newtonsMethod(f_handle_NL, x_NL);
            %x_S = [0.2608;-0.2086];
            x_S = [-0.2647;0.2118];
            if (norm(x_s1-x_S)>1.0e-4)
                error('newtonsMethod:result','result is wrong');
            end
            stepcheck = newtonsMethod(f_handle_NL, x_0,1e-5, 4);
            stepcheck_i = [-0.2694; 0.1813];
            if (norm(stepcheck-stepcheck_i)>1.0e-4)
                disp('Regarding the upcoming error:');
                disp('You need to use backtracking with Newton direction and bisection line search for steepest descent')
                error('newtonsMethod:step size','wrong line search config');
            end
            
            disp('newtonsMethod.m seems to be correct.');            			           
            disp('');
            disp('Initialize visualization...');
            n_NL=6;
            x_all_NL = [x_NL,zeros(2,n_NL)];
            for k=1:n_NL
                x_all_NL(1:2,k+1) = newtonsMethod(f_handle_NL, x_NL, 1e-5, k);
            end
            
            n_RB=12;
            x_all_RB = [x_0,zeros(2,n_RB)];
            for k=1:n_RB
                x_all_RB(1:2,k+1) = newtonsMethod(f_handle_RB, x_0, 1e-5, k);
            end                       
           
            disp('You should see your personal warning messages several times.')
            disp('These occur, whenever the algorithm hits domains with f having negative curvature.')
            disp('newtonsMethod.m seems to be correct.')
            
            clf
            subplot(1,2,1)
            plotFunction(f_handle_RB,[-0.5;-0.5],[1.5,1.5],50);
            axis([-0.5,1.5,-0.5,1.5,-0.5,200]);
            view([-25,60]);           
            hold on
            for k=1:n_RB-1
                plot3([x_all_RB(1,k),x_all_RB(1,k+1)],[x_all_RB(2,k),x_all_RB(2,k+1)],[f_handle_RB(x_all_RB(:,k)),f_handle_RB(x_all_RB(:,k+1))],'g*-', 'linewidth', 2);
            end         
               
            title('Newton´s Method converges quadratically to (LMP).');
            hold off
            
            subplot(1,2,2)
            plotFunction(f_handle_NL,[-0.5;-0.5],[1.5,1.5],50);
            axis([-0.5,1.5,-0.5,1.5,-0.5,5]);
            view([-64,50]);
           
            hold on
            for k=1:n_NL-1
                plot3([x_all_NL(1,k),x_all_NL(1,k+1)],[x_all_NL(2,k),x_all_NL(2,k+1)],[f_handle_NL(x_all_NL(:,k)),f_handle_NL(x_all_NL(:,k+1))],'r*-', 'linewidth', 2);
           end
            title('Newton´s Method with steepest descent fix for non-convex function. Can only find (LMP).');
            hold off
            
            
        catch ME
            disp('Error found in newtonsMethod.m');
            ME
        end
end

end
