function [var_omega_error, var_phi_error] = gen_var(SNR,k)
%GEN_VAR Summary of this function goes here
%   Detailed explanation goes here
mapstr = "SNR("+int2str(SNR)+")";
mapstr = mapstr+"_k("+int2str(k)+")";

omega_error_arr = load('../EstimationsFFTMatlab/'+mapstr+'/omega_error_arr.mat');
omega_error_arr = omega_error_arr.omega_error_arr;
phi_error_arr = load('../EstimationsFFTMatlab/'+mapstr+'/phi_error_arr.mat');
phi_error_arr = phi_error_arr.phi_error_arr;

var_omega_error = (omega_error_arr*omega_error_arr')/(size(omega_error_arr, 2)-1);
var_phi_error = phi_error_arr*phi_error_arr'/(size(phi_error_arr, 2)-1);
end

