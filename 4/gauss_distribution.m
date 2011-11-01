%Gaussian model function

function f = gauss_distribution(x, m, s)
p1 = -.5 * ((x - m)/s) .^ 2;
p2 = (s * sqrt(2*pi));
f = exp(p1) ./ p2; 