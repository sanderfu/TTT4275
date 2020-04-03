function [var_omega_error, var_phi_error] = gen_var_error(SNR,k, directory)
%GEN_VAR Returns variance in the error of signal estimates saved in files.

mapstr = "SNR("+int2str(SNR)+")";
mapstr = mapstr+"_k("+int2str(k)+")";

omega_error_arr = load('../'+directory+'/'+mapstr+'/omega_error_arr.mat');
omega_error_arr = omega_error_arr.omega_error_arr;
phi_error_arr = load('../'+directory+'/'+mapstr+'/phi_error_arr.mat');
phi_error_arr = phi_error_arr.phi_error_arr;

var_omega_error = var(omega_error_arr);
var_phi_error = var(phi_error_arr);
end


