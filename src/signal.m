function [X, X_real] = signal(N,SNR)
%SIGNAL Summary of this function goes here
%   Detailed explanation goes here
% Defining constant variables
T = 1e-6;
f0 = 1e5;
omega0 = 2*pi*f0;
phi = pi/8;
A = 1;

%Defining derived variables
n0 = - floor(N-1)/2;
SNR_linear = db2mag(SNR);

%Defining noise variables
var = A^2/(SNR_linear*2);
std = sqrt(var);
mean = 0;

%Creating the noise for all samples from normal distribution (Gaussian
%distribution)

omega_samples = std.*randn(1,N)+mean + 1i*std.*randn(1,N);
%omega_samples = omega_samples + 1i*omega_samples;
%Allocate space for signal samples
X = zeros(1,N);
X_real = zeros(1,N);
%Fill the signal array
for n=n0:n0+N-1
   X(n+abs(n0)+1) = A*exp(1i*(omega0*n*T+phi))+omega_samples(n+abs(n0)+1);
   X_real(n+abs(n0)+1) = A*exp(1i*(omega0*n*T+phi));
end


end

