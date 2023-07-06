% figure(3)
% % Define your independent variable
% t = 0 : 2*pi/360 : 2*pi; 
% 
% % Define values along your x-axis
% x = exp(t);
% % Define values along your y-axis
% y = 50 + exp(3*t); 
% 
% % Plot your function with a wider line and grid the figure
% loglog(x, y, 'LineWidth', 2)
% grid 
% 
% % Use a title for the figure
% title('Demonstration of logarithmic plots') 
% 
% % Label your x-axis with a double line.
% % Note the special characters
% xlabel([{'e^{t}'}; {'0 \leq t \leq 2\pi'}]) 
% 
% % Label your y-axis
% ylabel('50 + e^{3t}')
% 
% 
% figure(4)
% % define your linear data
% x = 0 : 1000;
% % define your logarithmic function
% y = log(x);
% 
% % plot your log function on linear data
% semilogx(x, y)
% 
% % define values of axes and grid
% axis([1 1000 0 7])
% grid 
% 
% % add relevant info 
% title('Example of Semilogx')
% xlabel('x')
% ylabel('y = log(x)')
% 
% 
% figure(5)
% % now your data along the x-axis is linear
% x = 0 : 0.5 : 10;
% 
% % your function is now exponential
% y = exp(x);
% 
% % see the plot
% semilogy(x, y)
% grid on
% % add info
% title('Example of Semilogy')
% xlabel('x')
% legend('y = e^x')