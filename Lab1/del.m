mu = [5 10];
sigma = [8 0; 0 4];
R = chol(sigma);
z = repmat(mu,10,1) + randn(10,2)*R