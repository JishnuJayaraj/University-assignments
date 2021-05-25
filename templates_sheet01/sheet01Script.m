% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function []=sheet01Script(n)

if nargin < 1
    disp('Please set assignment number as argument to test')
    return;
end

switch n
    
    case 1
        try
            % data for testing
            f_handle = @quadraticFunction;
            eps = 1.0e-2;
            x_k = [1; 0];
            d_k = [-3;2];
            t_s = bisectionLineSearch(f_handle, x_k, d_k, eps);
            if (abs(0.2031-t_s)>1.0e-4)
                error('bisectionLineSearch:result','bisectionLineSearch.m returns wrong result');
            end
            disp('bisectionLineSearch.m seems to be correct');
            
            disp('Initialize visualization...');
            n=6;
            x_all = zeros(2,n);
            x_all(1:2,1) = x_k;
            for k=2:n
                x_all(1:2,k) = x_k+bisectionLineSearch(f_handle, x_k, d_k, eps, k)*d_k;
            end
            
            clf
            plotFunction(f_handle,[-0.2;-0.2],[1.2,1.2],50);
            axis([-0.2,1.2,-0.2,1.2,-0.2,100]);
            title('bisectionLineSearch generates a descending sequence.');
            view([-25,60]);
            hold on
            
            for k=1:n-1
                plot3([x_all(1,k),x_all(1,k+1)],[x_all(2,k),x_all(2,k+1)],[f_handle(x_all(:,k)),f_handle(x_all(:,k+1))],'g*-', 'linewidth', 2);
            end
            
            hold off
            disp('Examine the plot to see the descend path of bisectionLineSearch.m...');
            
            
        catch ME
            disp('Error found in bisectionLineSearch.m');
            disp(ME);
        end
        
    case 2
        try
            
            f_handle = @quadraticFunction;
            x_k = [1; 0];
            d_k = [-3;2];
            sigma=0.25;
            beta=0.8;
            t_s = backtrackingLineSearch(f_handle, x_k, d_k, sigma, beta);
            if (abs(0.2621-t_s)>1.0e-4)
                error('backtrackingLineSearch:result','backtrackingLineSearch.m returns wrong result');
            end
            disp('backtrackingLineSearch.m seems to be correct.');
            
            disp('');
            disp('Initialize visualization...');
            n=6;
            x_all = zeros(2,n);
            for k=1:n
                x_all(1:2,k) = x_k+backtrackingLineSearch(f_handle, x_k, d_k, sigma, beta, k)*d_k;
            end
            
            clf
            plotFunction(f_handle,[-0.3;-0.3],[1.5,1.5],50);
            axis([-0.2,1.2,-0.2,1.2,-0.2,100]);
            hold on
            
            t_sigma=3/10; %only works for this specific f_handle
            x_sigma=x_k+t_sigma*d_k;
            plot3([x_k(1,1),x_sigma(1,1)],[x_k(2,1),x_sigma(2,1)],[f_handle(x_k),f_handle(x_sigma)],'r*:', 'linewidth', 3);
            
            for k=1:n-1
                plot3([x_k(1,1),x_all(1,k+1)],[x_k(2,1),x_all(2,k+1)],[f_handle(x_k),f_handle(x_all(:,k+1))],'g*-', 'linewidth', 2);
            end
            title('backtrackingLineSearch returns any step size leading to sufficient decrease (below red line).');
            view([-25,60]);
            hold off
            disp('Examine the plot to see the descend path of backtrackingLineSearch.m...');
            disp('')
            disp('We call backtrackingLineSearch now with a NON-DESCENT DIRECTION. This has to fail.');
            disp('')
            disp('If you get your PERSONAL error message now, backtrackingLineSearch.m is complete.');
            
            backtrackingLineSearch(f_handle, x_k, -d_k, sigma, beta);
        catch ME
            disp('Error found in backtrackingLineSearch.m');
            disp(ME);
        end
end

end