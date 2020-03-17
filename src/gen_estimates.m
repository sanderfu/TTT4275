clear;

%True values:
f0 = 1e5;
phi = pi/8;
omega0 = 2*pi*f0;

estimation_samples = 500;
N=513;
%k_values = [10,12,14,16,18];
k_values = 1;
%SNR_values = [-10,0,10,20,30,40,50,60];
SNR_values = -10;
for i = 1:size(k_values,2)
    for SNR_index=1:size(SNR_values,2)
        SNR = SNR_values(SNR_index);
        fprintf("Starting new run, k=%i and SNR=%i\n",k_values(i),SNR_values(SNR_index));
        omega_error_arr = zeros(1,estimation_samples);
        phi_error_arr = zeros(1,estimation_samples);
        
        for j=1:estimation_samples
            if mod(j,estimation_samples/10)==0
                fprintf("Progress: %i%%\n",j/estimation_samples*100)
            end
            [X, ~] = signal(N,SNR);

            k = k_values(i);

            omega_hat=find_omega_hat(k,X);
            omega_error_arr(j)=omega0-omega_hat;
            
            phi_hat=find_phase_hat(omega_hat, X);
            phi_error_arr(j)=phi-phi_hat;
        end
        mapstr = "SNR("+int2str(SNR_values(SNR_index))+")";
        mapstr = mapstr+"_k("+int2str(k_values(i))+")";
        mkdir('../Estimations',mapstr);
        save('../Estimations/'+mapstr+'/omega_error_arr.mat','omega_error_arr');
        save('../Estimations/'+mapstr+'/phi_error_arr.mat','phi_error_arr');


    end
end