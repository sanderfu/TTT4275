function []= plottingVariances()
%PLOTTINGVARIANCES Summary of this function goes here
%   Detailed explanation goes here
close all;
clear;
clc;
SNR = [-10, 0, 10, 20, 30, 40, 50, 60];
SNR_mag = db2mag(SNR);
num_snr_values = size(SNR_mag, 2);
omegas_crlb = zeros(1, num_snr_values);
phis_crlb = zeros(1, num_snr_values);

for i = 1:num_snr_values
    [omegas_crlb(i), phis_crlb(i)] = get_CRLB(SNR_mag(i));
end

k_values = [10, 12, 14];
variance_arrays_omega = [];
variance_arrays_phi = [];
for k = 1:size(k_values, 2)
    variance_for_different_snr_omega = zeros(1, size(SNR, 2));
    variance_for_different_snr_phi = zeros(1, size(SNR, 2));
    for j = 1:size(SNR, 2)
        [variance_for_different_snr_omega(j),  variance_for_different_snr_phi(j)] = gen_var(SNR(j), k_values(k));
    end
    
    variance_arrays_omega = [variance_arrays_omega; variance_for_different_snr_omega];
    variance_arrays_phi = [variance_arrays_phi; variance_for_different_snr_phi];
end





figure()
subplot(2, 1, 1)
semilogy(SNR, omegas_crlb, 'black');
for k = 1:size(k_values, 2)
    hold on;
    semilogy(SNR, variance_arrays_omega(k,:));
end
legend('CRLB', 'k=10', 'k=12', 'k=14', 'k=16', 'k=18')


subplot(2, 1, 2);
semilogy(SNR, phis_crlb, 'black');
hold on;
for k = 1:size(k_values, 2)
    hold on;
    semilogy(SNR, variance_arrays_phi(k,:));
end
legend('CRLB', 'k=10', 'k=12', 'k=14', 'k=16', 'k=18')

end

