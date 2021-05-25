% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function []=sheet03Script(n)

if nargin < 1
    disp('Please set assignment number as argument to test')
    return;
end

switch n
    case 1
        try
            f1 = @nonlinearFunction;
            x_0 = [0;0];
            eps = 1.0e-5;
            h = eps / 1000;
            
            
            d0 = CGDirection(f1, x_0, h);
            ds0=[1.6079; -1.2863];
            if (norm(d0-ds0)>1.0e-4)
                error('CGDirection:result','behavior for negative curvature at j==1 is wrong');
            end
            
            x_1 = [-0.2;0.1];
            
            d1 = CGDirection(f1, x_1, h);
            ds1=[-0.4015;  0.4134];
            if (norm(d1-ds1)>1.0e-4)
                error('CGDirection:result','behavior for positive curvature is wrong');
            end
            
            x_2 = [-0.2;-0.2];
            
            d2 = CGDirection(f1, x_2, h);
            ds2=[-0.0372;   -0.0948];
            if (norm(d2-ds2)>1.0e-4)
                error('CGDirection:result','behavior for negative curvature at j>1 is wrong');
            end
            
            disp('CGDirection.m seems to be correct.');
            disp('');
            disp('Initialize visualization...');
            
            alpha = 0;
            beta = 1;
            
            x_0=[alpha; beta];
            f_handle_NL=@rosenbrockFunction;
            n_NL=18;
            x_all_NLA = [x_0,zeros(2,n_NL)];
            for k=1:n_NL
                if (k==n_NL) 
                    verbose = true;
                else
                    verbose = false;
                end
                x_all_NLA(1:2,k+1) = inexactNewtonCG(f_handle_NL, x_0, 1e-5, k, verbose);
            end
            
            x_all_NEWTON = [0 -0.00502512562814328 0.244968593122531 0.300883758576224 0.515956590875984 0.561777046591043 0.716091462836186 0.763627113303444 0.845026793483424 0.905773314214387 0.959988026613210 0.985186911129649 0.998330772271395 0.999944250741543 1 1 1 1 1
                1 -2.22044604925031e-15 -0.00250618671404471 0.0874045304472423 0.218391627611070 0.313493935914624 0.487924287004824 0.580866730106808 0.706314554738803 0.816735156961998 0.918637776200239 0.969958266080306 0.996491569778287 0.999885901278292 1 1 1 1 1];
            clf
            
            plotFunction(f_handle_NL,[-0.5;-0.5],[1.5,1.5],50);
            axis([-0.5,1.5,-0.5,1.5,-0.5,200]);
            view([-25,60]);
            
            hold on
            for k=1:n_NL-1
                plot3([x_all_NEWTON(1,k),x_all_NEWTON(1,k+1)],[x_all_NEWTON(2,k),x_all_NEWTON(2,k+1)],[f_handle_NL(x_all_NEWTON(:,k)),f_handle_NL(x_all_NEWTON(:,k+1))],'g*-', 'linewidth', 1);
             end
            
            for k=1:n_NL-1
                plot3([x_all_NLA(1,k),x_all_NLA(1,k+1)],[x_all_NLA(2,k),x_all_NLA(2,k+1)],[f_handle_NL(x_all_NLA(:,k)),f_handle_NL(x_all_NLA(:,k+1))],'r*-', 'linewidth', 1);            
            end
            title('In comparison Inexact Newton-CG (red path) is competitive to Newtons Method (green path), but Hessian computation is not required.');
            disp('Inexact Newton-CG can reach Q-quadratic convergence rate.');
            
            hold off
            
        catch ME
            disp('Error found in inexactNewtonCG.m');
            ME
        end
    case 2
        try
            
            xStart = [2; pi/50; 3; pi/50*0.9];
            xEnd = levMarq(@spiralFitting, xStart);
            x_S = [1.9999; 0.0628; 3.0001; 0.0691];
            if (norm(xEnd-x_S)>1.0e-4)
                error('levMarq:result','result is wrong');
            end
            disp('levMarq.m seems to be correct!');
            disp('');
            disp('Initialize visualization...');
            clf
            subplot(1,2,1);
            spiralFitting(xStart, 1);
            title('The spiral (green) defined by starting parameters x_0 does not fit the blue data.');
            view([-60,6]);
            subplot(1,2,2);
            spiralFitting(xEnd, 1);
            title('After optimization the parameters x_* define the optimal spiral (green) that fits the data (blue).');
            view([-60,6]);
            disp('In the visualization we try to fit a general spiral to given data.');
            disp('Enlarge the figure and rotate it to see the result of the fitting process.');
            
            
        catch ME
            disp('Error found in levMarq.m');
            ME
        end
end

end
