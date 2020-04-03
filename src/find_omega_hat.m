function [omega_hat] = find_omega_hat(k, x, T)
%FIND_OMEGA_HAT 
% Given a FFT size and signal samples, returns an estimate of
% the frequency.

if nargin<3
    T = 10^-6;
end
max_FFT = 0;
m_star = 1;
M = 2^k;
fft_values = fft(x, M);
[max_value, m_star] = max(abs(fft_values), [], 2, 'linear');

% Find argmax(FFT)
% for m = 1:M
%     current_FFT = abs(fast_fourier_transform(m, M, x, T));
%     if current_FFT>max_FFT
%         max_FFT = current_FFT;
%         m_star = m;
%     end
% end

omega_hat = 2*pi*m_star/(M*T);
end

