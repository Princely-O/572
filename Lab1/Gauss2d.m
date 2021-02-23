function Y = Gauss2d(x1, x2, mu, sigma)

Y = zeros( length(x1), length(x2));
for i=1:length(x1)
    for j=1:length(x2)
        v = [x1(i);x2(j)];
        Y(i,j)=1/(sqrt(2*pi)*det(sigma))*...
            exp(-0.5*(v-mu)'*inv(sigma)*(v-mu));
    end
end