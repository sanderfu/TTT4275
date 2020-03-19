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

error_before = abs(f_hat_before_fminsearch-f_real);
error_after = abs(f_hat_after_fminsearch-f_real);
disp('Error before');
disp(error_before);
disp('Error after');
disp(error_after);
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
errors_before = zeros(1, size(SNRs,2));
errors_after = zeros(1, size(SNRs,2));
k = 10;

for i = 1:size(SNRs, 2)
   
[X, X_real] = signal(N,SNRs(i), f_real);
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
errors_before(i) = error_before;
errors_after(i) = error_after;
end
T = 1:size(SNRs,2);
f1 = figure();
plot(T, errors_before);
hold on;
plot(T, errors_after);
legend('errors_before', 'errors_after');
f2 = figure();
plot(T, errors_after);

movegui(f1, 'west');
movegui(f2, 'east');