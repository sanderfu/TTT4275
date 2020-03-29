%% Using k=10 to obtain omega_hat, then further minimizing with fminsearch

close all;
clear;
clc;
%rng('shuffle');

%std_deviation = 5;

N = 513;
T = 1e-6;
f_real = 1e5;
SNR = 10;
[X, X_real] = signal(N,SNR);
k = 14;
plot(X, 'x');
hold on;
plot(X_real, 'o');


omega_hat_before_minsearch = find_omega_hat(k,X);

f_hat_before_fminsearch = omega_hat_before_minsearch/(2*pi);
phase_hat = find_phase_hat(omega_hat_before_minsearch, X);

[omega_hat_after_minsearch,FVAL,EXITFLAG,OUTPUT] = fminsearch(@(omega) -abs(Big_F(omega, X, T)), omega_hat_before_minsearch) ; 
f_hat_after_fminsearch = omega_hat_after_minsearch/(2*pi);

error_before_omega = abs(f_hat_before_fminsearch-f_real);
error_after_omega = abs(f_hat_after_fminsearch-f_real);
disp('Error before');
disp(error_before_omega);
disp('Error after');
disp(error_after_omega);
disp('Final f:');
disp(f_hat_after_fminsearch);

%% Different values of SNR
close all;
clear;
clc;
N = 513;
T = 1e-6;
f_real = 1e5;
SNRs = [-10, 0, 10, 20, 30, 40, 50, 60];
errors_before_omega_k10 = zeros(1, size(SNRs,2));
errors_before_omega_k20 = zeros(1, size(SNRs,2));
errors_after_omega = zeros(1, size(SNRs,2));
errors_before_phase_k10 = zeros(1, size(SNRs,2));
errors_before_phase_k20 = zeros(1, size(SNRs,2));
errors_after_phase = zeros(1, size(SNRs,2));
k10 = 10;
k20 = 20;
phase_0 = pi/8;
for i = 1:size(SNRs, 2)
   
[X, X_real] = signal(N,SNRs(i), f_real);
plot(X, 'x');
hold on;
plot(X_real, 'o');


omega_hat_before_minsearch_k10 = find_omega_hat(k10,X);
omega_hat_before_minsearch_k20 = find_omega_hat(k20,X);

f_hat_before_fminsearch_k10 = omega_hat_before_minsearch_k10/(2*pi);
f_hat_before_fminsearch_k20 = omega_hat_before_minsearch_k20/(2*pi);

phase_hat_before_k10 = find_phase_hat(omega_hat_before_minsearch_k10, X);
phase_hat_before_k20 = find_phase_hat(omega_hat_before_minsearch_k20, X);

[omega_hat_after_minsearch,FVAL,EXITFLAG,OUTPUT] = fminsearch(@(omega) -abs(Big_F(omega, X, T)), omega_hat_before_minsearch_k10) ; 
f_hat_after_fminsearch = omega_hat_after_minsearch/(2*pi);
phase_hat_after = find_phase_hat(omega_hat_after_minsearch, X);
error_before_omega_k10 = abs(f_hat_before_fminsearch_k10-f_real);
error_before_omega_k20 = abs(f_hat_before_fminsearch_k20-f_real);
error_after_omega = abs(f_hat_after_fminsearch-f_real);
errors_before_omega_k10(i) = error_before_omega_k10;
errors_before_omega_k20(i) = error_before_omega_k20;
errors_after_omega(i) = error_after_omega;

errors_before_phase_k10(i) = abs(phase_hat_before_k10-phase_0);
errors_before_phase_k20(i) = abs(phase_hat_before_k20-phase_0);
errors_after_phase(i) = abs(phase_hat_after-phase_0);
end

f1 = figure();
plot(SNRs, errors_before_omega_k10);
hold on;
plot(SNRs, errors_after_omega);
legend('errors before post-processing', 'errors after post-processing');
title('Errors in estimation before and after post-processing, frequency');
xlabel('SNR');
ylabel('Error in frequency estimate');

f2 = figure();
plot(SNRs, errors_before_phase_k10);
hold on;
plot(SNRs, errors_after_phase);
legend('errors before post-processing', 'errors after post-processing');
title('Errors in estimation before and after post-processing, phase');
xlabel('SNR');
ylabel('Error in phase estimate');

movegui(f1, 'west');
movegui(f2, 'east');
