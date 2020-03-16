function [result] = Big_F(omega, x, T)
%BIG_F Calculates equation 6, given omega and x
%   Detailed explanation goes here
sum = 0;
if nargin<3
    T = 10^-6;
end
N = size(x, 2);
for n = 0:N-1
    sum = sum + x(n)*exp(-1i*omega*n*T);
end
result = sum/N;
end

