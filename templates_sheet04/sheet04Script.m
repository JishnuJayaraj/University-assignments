% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function []=sheet04Script(n)

if nargin < 1
    disp('Please set assignment number as argument to test')
    return;
end

switch n
    case 1
        try
            
            x31=[-2;2;0];
            x32=[0.95;0;2];
            x33=[0;-2;0];
            a=[-1;-1;-1];
            b=[1;1;1];
            [p31,A31]=projectIntoBox(x31,a,b,0.1);
            [p32,A32]=projectIntoBox(x32,a,b,0.1);
            [p33,A33]=projectIntoBox(x33,a,b,0.1);
            
            difference=norm([-1;1;0]-p31)+norm([0.95;0;1]-p32)+norm([0;-1;0]-p33)+norm(A31-[1 2])+norm(A32-[1 3])+norm(A33-[2]);
            
            if (difference>=10e-5)
                error('projectIntoBox:result','result is wrong');
            end
            
            clf
            s = 1.5;
            t = 1.8;
            u = 2;
            for phi= 0:pi/20:pi/2
                for theta = 0:pi/20:pi/2
                    y=[s*cos(phi)*cos(theta);t*sin(phi)*cos(theta);u*sin(theta)];
                    p = projectIntoBox(y, a, b, 0);
					plotProjectIntoBox(y, p, a, b);
                end
            end
            
            title('A set of points is projected to Omega defined by box constraints.');
            view(30,30);
            disp('projectIntoBox.m seems to be correct.');
            
        catch ME
            disp('Error found in projectIntoBox.m');
            ME
        end        
        
    case 2
        try
            a=[0;0];
            b=[0.8;0.8];
            p_handle = @(y)projectIntoBox(y,a,b);
            
            x_0=[0;1];
            f_handle = @rosenbrockFunction;
            eps=1.0e-5;
            
            xa = projectedNewton(f_handle, x_0, p_handle, eps);
            if (norm([0.8;0.64]-xa)>10e-5)
                error('projectedNewton:result','result is wrong');
            end
            disp('projectedNewton.m seems to be correct.')
            disp('');
            disp('Initialize visualization...');                        
                      
            n_RB=13;
            x_all_RB = [getProjectedPoint(p_handle,x_0),zeros(2,n_RB)];
            for k=1:n_RB
                x_all_RB(1:2,k+1) = projectedNewton(f_handle, x_0, p_handle, eps, k);
            end
            
            clf            
			plotFunction(f_handle,    [-0.1, -0.1], [1.1, 1.1], 50);
            
            hold on
            
            
            % plot rectangle
            m1 = [a(1); a(2)];
            m2 = [b(1); a(2)];
            m3 = [b(1); b(2)];
            m4 = [a(1); b(2)];
            t=0:0.01:1;
            y12 = m1 * (1-t) + m2 * (t);
            y23 = m2 * (1-t) + m3 * (t);
            y34 = m3 * (1-t) + m4 * (t);
            y41 = m4 * (1-t) + m1 * (t);
            y=[y12 y23 y34 y41];                                  
            m=size(y,2);
            z=zeros(1,m);
            for i=1:m
                z(i)=getValue(f_handle,y(:,i));
            end
            
            plot3(y(1,:)',y(2,:)',z','w-', 'linewidth', 2);
            
            for k=1:n_RB-1
                plot3([x_all_RB(1,k),x_all_RB(1,k+1)],[x_all_RB(2,k),x_all_RB(2,k+1)],[f_handle(x_all_RB(:,k)),f_handle(x_all_RB(:,k+1))],'g*-', 'linewidth', 2);
            end                     	            
			            
            title('projectedNewton converges to a stationary point on the box constraints (white).');
            hold off                        
            
            view(-30,50);
            axis([-0.25, 1.25, -0.25, 1.25, 0, 400]);
            disp('We minimize the objective on the white box. The descent path never leaves the box.')
            disp('Rotate the figure to see the descent path inside the box.');
            
        catch ME
            disp('Error found in projectedNewton.m');
            ME
        end
        
end

end
