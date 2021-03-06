clearvars
close all
clc

% Case 1
% NOTE: address transpose
N_A= 200;
N_B= 200;
mu_A= [5 10];
mu_B= [10 15];
sigma_A=[8 0; 0 4];
sigma_B=[8 0; 0 4];
%dx= 0.1;
% x1= [-N:dx:N];
% x2= [-N:dx:N];

% Case 2
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

R_A = chol(sigma_A);
z_A = repmat(mu_A,N_A,1) + randn(N_A,2)*R_A

R_B = chol(sigma_B);
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
w = [0.4; 0.6];
chiSqrDist = @(z_A,mu_A)sqrt((bsxfun(@minus,z_A,mu_A).^2)*w);
[Idx,D] = knnsearch(z_A,z_A,'Distance',chiSqrDist,'k',1);
for j = 1:1;
    h(3) = plot(z_A(Idx(:,j),1),z_A(Idx(:,j),2),'bo','MarkerSize',10);
end
hold on
w = [0.4; 0.6];
chiSqrDist = @(z_B,mu_B)sqrt((bsxfun(@minus,z_B,mu_B).^2)*w);
[Idx,D] = knnsearch(z_B,z_B,'Distance',chiSqrDist,'k',1);
for j = 1:1;
    h(3) = plot(z_B(Idx(:,j),1),z_B(Idx(:,j),2),'ro','MarkerSize',10);
end
title('Case 1 NN');
xlabel 'x1';
ylabel 'x2';
legend('Class A Nearest Neighbours','Class B Nearest Neighbours');


%KNN
knn_X = cat(1, z_A, z_B);

rng(1); % For reproducibility
[idx,C] = kmeans(knn_X,5);

figure(3);
gscatter(knn_X(:,1),knn_X(:,2),idx)
hold on
plot(C(:,1),C(:,2),'kx', 'MarkerSize',15,'LineWidth',3)
title 'Case 1 KNN';
xlabel 'x1'; 
ylabel 'x2';
legend('Centroid A','Centroid B','Centroid C','Centroid D','Centroid E');
hold off;

% end of Case 1-----------------------------------------------------------

% Case 2
% generating clusters
% transformation

sigma_Ctr = whiten(sigma_C, 0.7)
sigma_Dtr = whiten(sigma_D, 0.7)
sigma_Etr = whiten(sigma_E, 0.7)

R_C = chol(sigma_C);
z_C = repmat(mu_C,N_C,1) + randn(N_C,2)*R_C
R_D = chol(sigma_D);
z_D = repmat(mu_D,N_D,1) + randn(N_D,2)*R_D
R_E = chol(sigma_E);
z_E = repmat(mu_E,N_E,1) + randn(N_E,2)*R_E

% classifiers
% MED
prototype_C = mu_C;
prototype_D = mu_D;
prototype_E = mu_E;
% plot
figure(4)
scatter(z_C(:,1),z_C(:,2),'o')
title('Case 2 MED GED MAP')
hold on
scatter(z_D(:,1),z_D(:,2),'x')
hold on
scatter(z_E(:,1),z_E(:,2),'x', 'g')
scatter(prototype_C(:,1),prototype_C(:,2),'d', 'filled');
scatter(prototype_D(:,1),prototype_D(:,2),'s', 'filled');
scatter(prototype_E(:,1),prototype_E(:,2),'s', 'filled');
% unit standard deviation contours
% class C
t = linspace(0,2 * pi,1000);
theta0 = atan2(-16-4*sqrt(17),-16-4*sqrt(17));
a=sqrt((48-sqrt(1088))/2);
b=sqrt((48+sqrt(1088))/2);
x = 5 + a * sin(t+theta0);
y = 10 + b * cos(t);
plot(x,y, 'b')
% 
% % class D
t = linspace(0,2 * pi,1000);
theta0 = atan2(0,0);
a=sqrt(8);
b=sqrt(8);
x = 15 + a * sin(t+theta0);
y = 10 + b * cos(t);
plot(x,y, 'r')
axis equal

% % class E
t = linspace(0,2 * pi,1000);
theta0 = atan2(-5-5*sqrt(2),-5-5*sqrt(2));
a=sqrt((30-sqrt(200))/2);
b=sqrt((30+sqrt(200))/2);
x = 10 + a * sin(t+theta0);
y = 5 + b * cos(t);
plot(x,y, 'g')

y_1 = 0 : 20;
m_1 = 0;
b_1 = 10;
x_1 = m_1*y_1 + b_1;

x_2 = 0 : 20;
m_2 = -1;
b_2 = 20;
y_2 = m_2*x_2 + b_2;

x_3 = 0 : 20;
m_3 = 1;
b_3 = 0;
y_3 = m_3*x_3 + b_3;
plot(x_1,y_1, 'm')
plot(x_2,y_2, 'm')
plot(x_3,y_3, 'm')
xlabel 'x1'; 
ylabel 'x2';
legend('Class C','Class D', 'Class E', 'Class C prototype','Class D prototype', 'Class E prototype', 'Class C contour', 'Class D contour', 'Class E contour', 'MED boundaries');


% end of Case 2-----------------------------------------------------------
% y = Gauss2d(x1, x2, mu, sigma)