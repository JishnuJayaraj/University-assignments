% *********************************************
% * Optimization for Engineers 2018 - Dr. Johannes Hild
% *********************************************

function plotProjectIntoBox(x, x_all, a, b)

    start=[...
        a(1),a(2),a(3);b(1),a(2),a(3);b(1),b(2),a(3);a(1),b(2),a(3);...
        a(1),a(2),a(3);b(1),a(2),a(3);b(1),b(2),a(3);a(1),b(2),a(3);...
        a(1),a(2),b(3);b(1),a(2),b(3);b(1),b(2),b(3);a(1),b(2),b(3)];
    stop=[...
        b(1),a(2),a(3);b(1),b(2),a(3);a(1),b(2),a(3);a(1),a(2),a(3);...
        a(1),a(2),b(3);b(1),a(2),b(3);b(1),b(2),b(3);a(1),b(2),b(3);...
        b(1),a(2),b(3);b(1),b(2),b(3);a(1),b(2),b(3);a(1),a(2),b(3)];
    hold on
    grid on
    for j=1:12
        plot3([start(j,1);stop(j,1)],[start(j,2);stop(j,2)],[start(j,3);stop(j,3)],':*','color', 'red', 'linewidth', 3);
    end

	%Draw projection lines from
	plot3([x(1);x_all(1)],[x(2);x_all(2)],[x(3);x_all(3)],'-*','color', 'green', 'linewidth', 1);
    
    hold off
end
