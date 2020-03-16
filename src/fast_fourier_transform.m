function [result] = fast_fourier_transform(m, M, x, T)
%FAST-FOURIER-TRANSFORM Summary of this function goes here
%   Detailed explanation goes here
if nargin<4
    T = 10^-6;
end
omega_m = 2*pi*m/(M*T);
result = Big_F(omega_m, x, T);
end

