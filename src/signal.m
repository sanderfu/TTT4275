function [X, X_real] = signal(N,SNR,f)
%SIGNAL Generate a complex exponential signal embedded in White Gaussian
%Noise

% Defining constant variables
T = 1e-6;
if nargin < 3
f = 1e5;
end
f0 = f;
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


%Allocate space for signal samples
X = zeros(1,N);
X_real = zeros(1,N);
%Fill the signal array
for n=n0:n0+N-1
   X(n+abs(n0)+1) = A*exp(1i*(omega0*n*T+phi))+std.*randn(1,1)+mean + 1i*std.*randn(1,1);
   X_real(n+abs(n0)+1) = A*exp(1i*(omega0*n*T+phi));
end


end

