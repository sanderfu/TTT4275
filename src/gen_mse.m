function [mse_omega, mse_phi] = gen_mse(SNR,k, directory)
%GEN_VAR Summary of this function goes here
%   Detailed explanation goes here
mapstr = "SNR("+int2str(SNR)+")";
mapstr = mapstr+"_k("+int2str(k)+")";

omega_error_arr = load('../'+directory+'/'+mapstr+'/omega_error_arr.mat');
omega_error_arr = omega_error_arr.omega_error_arr;
phi_error_arr = load('../'+directory+'/'+mapstr+'/phi_error_arr.mat');
phi_error_arr = phi_error_arr.phi_error_arr;


mse_omega = (omega_error_arr*omega_error_arr.')/size(omega_error_arr,2);
mse_phi = (phi_error_arr*phi_error_arr.')/size(phi_error_arr,2);
end

