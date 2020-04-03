function [var_omega_hat, var_phi_hat] = gen_var(SNR,k, directory)
%GEN_VAR Returns estimated variance of signal samples stored in files.

mapstr = "SNR("+int2str(SNR)+")";
mapstr = mapstr+"_k("+int2str(k)+")";

omega_hat_arr = load('../'+directory+'/'+mapstr+'/omega_hat_arr.mat');
omega_hat_arr = omega_hat_arr.omega_hat_arr;
phi_hat_arr = load('../'+directory+'/'+mapstr+'/phi_hat_arr.mat');
phi_hat_arr = phi_hat_arr.phi_hat_arr;

var_omega_hat = var(omega_hat_arr);
var_phi_hat = var(phi_hat_arr);
end

