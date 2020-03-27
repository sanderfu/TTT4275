function [var_omega_error, var_phi_error] = gen_var(SNR,k, directory)
%GEN_VAR Summary of this function goes here
%   Detailed explanation goes here
mapstr = "SNR("+int2str(SNR)+")";
mapstr = mapstr+"_k("+int2str(k)+")";

omega_hat_arr = load('../'+directory+'/'+mapstr+'/omega_hat_arr.mat');
omega_hat_arr = omega_hat_arr.omega_hat_arr;
phi_hat_arr = load('../'+directory+'/'+mapstr+'/phi_hat_arr.mat');
phi_hat_arr = phi_hat_arr.phi_hat_arr;

var_omega_error = var(omega_hat_arr);
var_phi_error = var(phi_hat_arr);
end

