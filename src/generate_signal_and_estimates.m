clear;
warning('off', 'MATLAB:MKDIR:DirectoryExists');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Script for generating all necessary estimation samples 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%True values:
f0 = 1e5;
phi = pi/8;
omega0 = 2*pi*f0;

%Configuration
estimation_samples = 500;
N=513;
k_values = [10, 12, 14, 16, 18, 20, 22, 24, 26];
SNR_values = [-10, 0, 10, 20, 30, 40, 50, 60];

for i = 1:size(k_values,2)
    for SNR_index=1:size(SNR_values,2)
        % Choosing SNR
        SNR = SNR_values(SNR_index);
        
        %Inform that new run is starting and allocate space for results
        fprintf("Starting new run, k=%i and SNR=%i\n",k_values(i),SNR);
        omega_error_arr = zeros(1,estimation_samples);
        phi_error_arr = zeros(1,estimation_samples);
        omega_hat_arr = zeros(1,estimation_samples);
        phi_hat_arr = zeros(1,estimation_samples);
        
        %Produce estimation samples
        for j=1:estimation_samples
            if mod(j,estimation_samples/10)==0
                fprintf("Progress: %i%%\n",j/estimation_samples*100)
            end
            [X, ~] = signal(N,SNR);

            k = k_values(i);

            omega_hat_arr(j)=find_omega_hat(k,X);
            omega_error_arr(j)=omega0-omega_hat_arr(j);
            
            phi_hat_arr(j)=find_phase_hat(omega_hat_arr(j), X);
            phi_error_arr(j)=phi-phi_hat_arr(j);
        end
        
        %Save the results of the run in nonvolatile memory
        mapstr = "SNR("+int2str(SNR_values(SNR_index))+")";
        mapstr = mapstr+"_k("+int2str(k_values(i))+")";
        mkdir('../EstimationsFFTMatlab', mapstr);
        save('../EstimationsFFTMatlab/'+mapstr+'/omega_error_arr.mat','omega_error_arr');
        save('../EstimationsFFTMatlab/'+mapstr+'/phi_error_arr.mat','phi_error_arr');
        save('../EstimationsFFTMatlab/'+mapstr+'/omega_hat_arr.mat','omega_hat_arr');
        save('../EstimationsFFTMatlab/'+mapstr+'/phi_hat_arr.mat','phi_hat_arr');

    end
    fprintf("Total progress: %i%%\n",i/size(k_values,2)*100);
end