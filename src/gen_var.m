function [var_omega_error, var_phi_error] = gen_var(SNR,k)
%GEN_VAR Summary of this function goes here
%   Detailed explanation goes here
mapstr = "SNR("+int2str(SNR)+")";
mapstr = mapstr+"_k("+int2str(k)+")";

omega_error_arr = load('../Estimations/'+mapstr+'/omega_error_arr.mat');
omega_error_arr = omega_error_arr.omega_error_arr;
phi_error_arr = load('../Estimations/'+mapstr+'/phi_error_arr.mat');
phi_error_arr = phi_error_arr.phi_error_arr;

var_omega_error = var(omega_error_arr);
var_phi_error = var (phi_error_arr);
end

