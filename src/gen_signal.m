
floor(513/2)

db2mag(1)

std_deviation = 5;

N = 513;
SNR = 10;
X = signal(N,SNR);
n = linspace(-256,256,513);
k=10;
omega_hat = find_omega_hat(k,X);
