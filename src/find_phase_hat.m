function [phase_hat] = find_phase_hat(omega_hat, x, n0, T)
%FIND_PHASE_HAT Summary of this function goes here
%   Detailed explanation goes here
if nargin < 3
    n0 = -256;
end
if nargin < 4
    T = 10^-6;
end
phase_hat = angle(exp(-1i*omega_hat*n0*T*Big_F(omega_hat, x, T)));
end

