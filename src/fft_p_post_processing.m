%% Using k=10 to obtain omega_hat, then further minimizing with fminsearch

close all;
clear;
clc;
%rng('shuffle');

floor(513/2)

db2mag(1)

%std_deviation = 5;

N = 513;
T = 1e-6;
f_real = 1e5;
SNR = 10;
[X, X_real] = signal(N,SNR);
k = 10;
plot(X, 'x');
hold on;
plot(X_real, 'o');



omega_hat_before_minsearch = find_omega_hat(k,X);

f_hat_before_fminsearch = omega_hat_before_minsearch/(2*pi);
phase_hat = find_phase_hat(omega_hat_before_minsearch, X);

[omega_hat_after_minsearch,FVAL,EXITFLAG,OUTPUT] = fminsearch(@(omega) -abs(Big_F(omega, X, T)), omega_hat_before_minsearch) ; 
f_hat_after_fminsearch = omega_hat_after_minsearch/(2*pi);

error_before = abs(f_hat_before_fminsearch-f_real);
error_after = abs(f_hat_after_fminsearch-f_real);
disp('Error before');
disp(error_before);
disp('Error after');
disp(error_after);
disp('Final f:');
disp(f_hat_after_fminsearch);
