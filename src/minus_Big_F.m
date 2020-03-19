function [result] = minus_Big_F(omega, x, T)
%BIG_F Calculates equation 6, given omega and x
%   Detailed explanation goes here
sum = 0;
if nargin<3
    T = 10^-6;
end
N = size(x, 2);
n0 = -256;
for n = 1:N
    sum = sum + x(n)*exp(-1i*omega*(n-1)*T);
end
result = -sum/N;
end

