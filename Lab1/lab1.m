clearvars
close all
clc

% Case 1
% address transpose
N_A= 200;
N_B= 200;
mu_A= [5 10];
mu_B= [10 15];
sigma_A=[8 0; 0 4];
sigma_B=[8 0; 0 4];
%dx= 0.1;
% x1= [-N:dx:N];
% x2= [-N:dx:N];

% Case 1
N_C= 100;
N_D= 200;
N_E= 150;
mu_C= [5 10];
mu_D= [15 10];
mu_E= [10 5];
sigma_C=[8 0; 4 40];
sigma_D=[8 0; 0 8];
sigma_E= [10 -5; -5 20];

% generating clusters
% case 1
% transformation
sigma_Atr = whiten(sigma_A, 0.7)
sigma_Btr = whiten(sigma_B, 0.7)

R_A = chol(sigma_Atr);
z_A = repmat(mu_A,N_A,1) + randn(N_A,2)*R_A

R_B = chol(sigma_Btr);
z_B = repmat(mu_B,N_B,1) + randn(N_B,2)*R_B

% classifiers
% MED
% case 1
prototype_A = mu_A;
prototype_B = mu_B;
% th = 0:pi/50:2*pi;
% xunit = 1 * cos(th) + (5*sqrt(2))/4;
% yunit = 1 * sin(th) + 5;

% plot
scatter(z_A(:,1),z_A(:,2),'o')
title('Case 1 MED GED MAP')
hold on
scatter(z_B(:,1),z_B(:,2),'x')
scatter(prototype_A(:,1),prototype_A(:,2),'d', 'filled');
scatter(prototype_B(:,1),prototype_B(:,2),'s', 'filled');
x = 0 : 20;
m = -1;
b = 20;
y = m*x + b;
plot(x,y, 'm')
% GED (MICD)
x = 0 : 15;
m = -3/10;
b = 14.75;
y = m*x + b;
plot(x,y);
plot([5 10], [10 15], 'k');
plot(15/2,25/2,'k*')  % midpoint between classes
%MAP Decision Boundary Equation
x = 0 : 20;
m = -0.5;
b = 65/4;
y = m*x + b;
plot(x,y, 'g')

% unit standard deviation contours
% class A
t = linspace(0,2 * pi,1000);
theta0 = atan2(-4,-4);
a=sqrt(4);
b=sqrt(8);
x = 5 + a * sin(t+theta0);
y = 10 + b * cos(t);
plot(x,y, 'b')

% class B
t = linspace(0,2 * pi,1000);
theta0 = atan2(-4,-4);
a=sqrt(4);
b=sqrt(8);
x = 10 + a * sin(t+theta0);
y = 15 + b * cos(t);
plot(x,y, 'r')
axis equal



% t = linspace(0,2 * pi,1000);
% theta0 = atan2(y2,y1);
% a=sqrt(lambda_1);
% b=sqrt(lambda_2);
% x = x_mean + a * sin(t+theta0);
% y = y_mean + b * cos(t);
% plot(x,y)
% axis equal
% h = plot(xunit, yunit);

% sd_A = std(sigma_A)
% contour(sd_A);

hold off
xlabel('x1') 
ylabel('x2')
legend('Class A','Class B', 'Class A prototype','Class B prototype', 'MED boundary', 'GED boundary', 'Class distance', 'Midpoint', 'MAP boundary','Class A contour', 'Class B contour')

% NN
figure(2);
scatter(z_A(:,1),z_A(:,2),'o')
title('Case 1 NN KNN')
hold on
scatter(z_B(:,1),z_B(:,2),'x')

% unit standard deviation contours
% class A
t = linspace(0,2 * pi,1000);
theta0 = atan2(-4,-4);
a=sqrt(4);
b=sqrt(8);
x = 5 + a * sin(t+theta0);
y = 10 + b * cos(t);
plot(x,y, 'b')

% class B
t = linspace(0,2 * pi,1000);
theta0 = atan2(-4,-4);
a=sqrt(4);
b=sqrt(8);
x = 10 + a * sin(t+theta0);
y = 15 + b * cos(t);
plot(x,y, 'r')
axis equal
 
hold off


% y = Gauss2d(x1, x2, mu, sigma)