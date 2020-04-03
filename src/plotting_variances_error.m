function []= plotting_variances_error()
%plotting_variances_error plots the variance of the error in estimates of frequency
%and phase.

%% Plotting outFFT
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

k_values = [10,12, 14,16,18, 20];
variance_arrays_omega = [];
variance_arrays_phi = [];
for k = 1:size(k_values, 2)
    variance_for_different_snr_omega = zeros(1, size(SNR, 2));
    variance_for_different_snr_phi = zeros(1, size(SNR, 2));
    for j = 1:size(SNR, 2)
        [v_o, v_p] = gen_var_error(SNR(j), k_values(k), directory);
        if v_o < 1e-10
            v_o = 0;
        end
        variance_for_different_snr_omega(j) = v_o;
        variance_for_different_snr_phi(j)= v_p;
    end
    
    variance_arrays_omega = [variance_arrays_omega; variance_for_different_snr_omega];
    variance_arrays_phi = [variance_arrays_phi; variance_for_different_snr_phi];
end

f1_1 = figure()
semilogy(SNR, omegas_crlb, 'black');
for k = 1:size(k_values, 2)
    hold on;
    semilogy(SNR, variance_arrays_omega(k,:));
end
grid on;
title("Variance - Frequency estimation error, our FFT function");
xlabel("SNR (dB)");
ylabel("Variance");
legend('CRLB', 'k=10', 'k=12', 'k=14', 'k=16', 'k=18', 'k=20','Location', 'southwest')

f1_2 = figure()
semilogy(SNR, phis_crlb, 'black');
hold on;
for k = 1:size(k_values, 2)
    hold on;
    semilogy(SNR, variance_arrays_phi(k,:));
end
grid on;
legend('CRLB', 'k=10', 'k=12', 'k=14', 'k=16', 'k=18', 'k=20','Location', 'southwest')
title("Variance - Phase estimation error, our FFT function");
xlabel("SNR (dB)");
ylabel("Variance");

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
        [v_o, v_p] = gen_var_error(SNR(j), k_values(k), directory);
        if v_o < 1e-10
            v_o = 0;
        end
        variance_for_different_snr_omega(j) = v_o;
        variance_for_different_snr_phi(j)= v_p;
       
    end
    
    variance_arrays_omega = [variance_arrays_omega; variance_for_different_snr_omega];
    variance_arrays_phi = [variance_arrays_phi; variance_for_different_snr_phi];
end




f2_1 = figure();
semilogy(SNR, omegas_crlb, 'black');
for k = 1:size(k_values, 2)
    hold on;
    semilogy(SNR, variance_arrays_omega(k,:));
end
grid on;
legend('CRLB', 'k=10', 'k=12', 'k=14', 'k=16', 'k=18', 'k=20','Location', 'southwest')
title("Variance - Frequency estimation error, Matlab's FFT function");
xlabel("SNR (dB)");
ylabel("Variance");

f2_2 = figure();
semilogy(SNR, phis_crlb, 'black');
hold on;
for k = 1:size(k_values, 2)
    hold on;
    semilogy(SNR, variance_arrays_phi(k,:));
end
grid on;
legend('CRLB', 'k=10', 'k=12', 'k=14', 'k=16', 'k=18', 'k=20','Location', 'southwest')
title("Variance - Phase estimation error, Matlab's FFT function");
xlabel("SNR (dB)");
ylabel("Variance");


movegui(f1_1, 'northwest')
movegui(f1_2, 'southwest')
movegui(f2_1, 'northeast')
movegui(f2_2, 'southeast')
end

