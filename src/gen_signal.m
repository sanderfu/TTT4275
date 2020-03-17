%% generate signal
close all;
clear;
clc;

floor(513/2)

db2mag(1)

%std_deviation = 5;

N = 513;
SNR = 10;
[X, X_real] = signal(N,SNR);

n = linspace(-256,256,513);
max_num = 4;
omega_hat = zeros(1,max_num);
idx = 1;
%X = [X, zeros(size(X,2), 1)'];
for k = 10:2:8+max_num*2
    omega_hat(idx) = find_omega_hat(k,X);
    idx = idx+1;
end
%omega_hat_real = find_omega_hat(k, X_real);
f_hat = omega_hat/(2*pi)
phase_hat = find_phase_hat(omega_hat(max_num), X);
plot(X, 'x');
hold on;
plot(X_real, 'o');

%% Plot Cramer Rao Lower Bound

plottingVariances();
