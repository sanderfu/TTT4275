function [result] = Big_F(omega, x, T)
% BIG_F Calculates equation 6 in task description.

sum = 0;
if nargin<3
    T = 10^-6;
end
N = size(x, 2);
for n = 1:N
    sum = sum + x(n)*exp(-1i*omega*(n-1)*T);
end
result = sum/N;
end

