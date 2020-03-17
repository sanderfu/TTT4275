function [var_omega, var_phi] = get_CRLB(SNR, N, n0, A, T)
%GET_CRLB Summary of this function goes here
%   Detailed explanation goes here
if nargin < 2
    N = 513;
end
if nargin < 3
    n0 = -256;
end
if nargin < 4
    A = 1;
end
if nargin < 5
    T = 1e-6;
end
A_squared = A^2;
P = N*(N-1)/2;
Q = N*(N-1)*(2*N-1)/6;
sigma_squared = A_squared/(2*SNR);
var_omega = 12*sigma_squared/(A_squared*T^2*N*(N^2-1));
var_phi = 12*sigma_squared*(n0^2*N + 2*n0*P + Q)/(A_squared*N^2*(N^2-1));
end

