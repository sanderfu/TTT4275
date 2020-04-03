function [result] = fast_fourier_transform(m, M, x, T)
%FAST-FOURIER-TRANSFORM 
% Given an index m, calculates the result of the
% Big_f function (equation 6) with the corresponding frequency

if nargin<4
    T = 10^-6;
end
omega_m = 2*pi*m/(M*T);
result = Big_F(omega_m, x, T);
end

