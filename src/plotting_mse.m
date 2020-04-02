function []= plotting_mse()
%PLOTTINGVARIANCES Summary of this function goes here
%   Detailed explanation goes here

%% Plotting our FFT
% close all;
% clear;
% clc;
directory = "Estimations";

SNR = [-10, 0, 10, 20, 30, 40, 50,60];
SNR_mag = db2mag(SNR);
num_snr_values = size(SNR_mag, 2);
omegas_crlb = zeros(1, num_snr_values);
phis_crlb = zeros(1, num_snr_values);

for i = 1:num_snr_values
    [omegas_crlb(i), phis_crlb(i)] = get_CRLB(SNR_mag(i));
end

k_values = [10, 12, 14,16,18, 20];
variance_arrays_omega = [];
variance_arrays_phi = [];
for k = 1:size(k_values, 2)
    variance_for_different_snr_omega = zeros(1, size(SNR, 2));
    variance_for_different_snr_phi = zeros(1, size(SNR, 2));
    for j = 1:size(SNR, 2)
        [mse_o, mse_p] = gen_mse(SNR(j), k_values(k), directory);
        if mse_o < 1e-10
            mse_o = 0;
        end
        variance_for_different_snr_omega(j) = mse_o;
        variance_for_different_snr_phi(j)= mse_p;
    end
    
    variance_arrays_omega = [variance_arrays_omega; variance_for_different_snr_omega];
    variance_arrays_phi = [variance_arrays_phi; variance_for_different_snr_phi];
end

f1_1 = figure();
semilogy(SNR, omegas_crlb, 'black');
for k = 1:size(k_values, 2)
    hold on;
    semilogy(SNR, variance_arrays_omega(k,:));
end
legend('CRLB', 'k=10', 'k=12', 'k=14', 'k=16', 'k=18', 'k=20','Location','southwest')
xlabel("SNR (dB)");
ylabel("Mean squared error");
title("MSE - Frequency, our FFT function");

f1_2 = figure()
semilogy(SNR, phis_crlb, 'black');
hold on;
for k = 1:size(k_values, 2)
    hold on;
    semilogy(SNR, variance_arrays_phi(k,:));
end
legend('CRLB', 'k=10', 'k=12', 'k=14', 'k=16', 'k=18', 'k=20', 'Location','southwest')
xlabel("SNR (dB)");
ylabel("Mean squared error");
title("MSE - Phase, our FFT-function");

%% Plotting MatlabFFT
directory = "EstimationsFFTMatlab";
SNR = [-10, 0, 10, 20, 30, 40, 50,60];
SNR_mag = db2mag(SNR);
num_snr_values = size(SNR_mag, 2);
omegas_crlb = zeros(1, num_snr_values);
phis_crlb = zeros(1, num_snr_values);

for i = 1:num_snr_values
    [omegas_crlb(i), phis_crlb(i)] = get_CRLB(SNR_mag(i));
end

k_values = [10, 12, 14,16,18, 20, 22, 24];
variance_arrays_omega = [];
variance_arrays_phi = [];
for k = 1:size(k_values, 2)
    variance_for_different_snr_omega = zeros(1, size(SNR, 2));
    variance_for_different_snr_phi = zeros(1, size(SNR, 2));
    for j = 1:size(SNR, 2)
        [mse_o, mse_p] = gen_mse(SNR(j), k_values(k), directory);
        if mse_o < 1e-10
            mse_o = 0;
        end
        variance_for_different_snr_omega(j) = mse_o;
        variance_for_different_snr_phi(j)= mse_p;    
    end
    
    variance_arrays_omega = [variance_arrays_omega; variance_for_different_snr_omega];
    variance_arrays_phi = [variance_arrays_phi; variance_for_different_snr_phi];
end




f2_1 = figure()
semilogy(SNR, omegas_crlb, 'black');
for k = 1:size(k_values, 2)
    hold on;
    semilogy(SNR, variance_arrays_omega(k,:));
end
legend('CRLB', 'k=10', 'k=12', 'k=14', 'k=16', 'k=18', 'k=20','Location','southwest')
xlabel("SNR (dB)");
ylabel("Mean squared error");
title("MSE - Frequency, Matlab's FFT function");

f2_2 = figure()
semilogy(SNR, phis_crlb, 'black');
hold on;
for k = 1:size(k_values, 2)
    hold on;
    semilogy(SNR, variance_arrays_phi(k,:));
end
legend('CRLB', 'k=10', 'k=12', 'k=14', 'k=16', 'k=18', 'k=20', 'Location','southwest')
xlabel("SNR (dB)");
ylabel("Mean squared error");
title("MSE - Phase, Matlab's FFT function");

movegui(f1_1, 'northwest')
movegui(f1_2, 'southwest')
movegui(f2_1, 'northeast')
movegui(f2_2, 'southeast')
end

