%% Task 1b) 

% Task 1b finds errors in estimates before and after post-processing and
% plots them.

% Subtasks:
% -Find an estimate of omega_hat and phase_hat using k=10 for all SNR values, with and
% without post-processing.
% -Estimate omega_hat and phase_hat using k=20 without post-processing
% -Find the error in the estimates and plot them


% Set constants.
N = 513;
T = 1e-6;
f_real = 1e5;
SNRs = [-10, 0, 10, 20, 30, 40, 50, 60];

% Allocate space in arrays.
errors_before_omega_k10 = zeros(1, size(SNRs,2));
errors_before_omega_k20 = zeros(1, size(SNRs,2));
errors_after_omega = zeros(1, size(SNRs,2));
errors_before_phase_k10 = zeros(1, size(SNRs,2));
errors_before_phase_k20 = zeros(1, size(SNRs,2));
errors_after_phase = zeros(1, size(SNRs,2));

k10 = 10;
k20 = 20;
phase_0 = pi/8;
signalFigure = figure();
for i = 1:size(SNRs, 2)
   
 %Generate and plot signals
 [X, X_real] = signal(N,SNRs(i), f_real);
 plot(X, 'x');
 hold on;
 plot(X_real, 'o');
 title('Plot of complex exponential signal');
 legend('X generated with f deterministic = 1e5', 'X generated with f stochastic, mean = 1e5');

 %Generate estimates.
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


% Plotting 

f1 = figure();
semilogy(SNRs, errors_before_omega_k10,'DisplayName', 'k=10, no post-processing','LineWidth',1.5);
hold on;
semilogy(SNRs, errors_after_omega,'DisplayName','k=10, with post-processing','LineWidth',1.5);
semilogy(SNRs, errors_before_omega_k20,'--','DisplayName', 'k=20, no post-processing','LineWidth',1.5);
ylim([10^-1 10^4]);
legend('location','northeast');
grid on;
xlabel('SNR (dB)');
ylabel('Error in frequency estimate');

f2 = figure();
plot(SNRs, errors_before_phase_k10,'DisplayName', 'k=10, no post-processing','LineWidth',1.5);
hold on;
plot(SNRs, errors_after_phase,'DisplayName','k=10, with post-processing','LineWidth',1.5);
plot(SNRs, errors_before_phase_k20,'--','DisplayName','k=20, no post-processing','LineWidth',1.5);
legend('location','northeast');
grid on;
xlabel('SNR (dB)');
ylabel('Error in phase estimate');

movegui(f1, 'west');
movegui(f2, 'east');
