function Y = ellipse(x_mean,y_mean,y2,y1,lambda_1, lambda_2)

t = linspace(0,2 * pi,1000);
theta0 = atan2(y2,y1);
a=sqrt(lambda_1);
b=sqrt(lambda_2);
x = x_mean + a * sin(t+theta0);
y = y_mean + b * cos(t);
plot(x,y)
axis equal
