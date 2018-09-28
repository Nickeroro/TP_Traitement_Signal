clear
f0 =128 %Hz
fe =100 %Hz
T = 0.125 %s

A = 5
Te = 1/fe
N = round(T / Te)
t = (0:1:N-1)*Te %vecteur de temps associé

xt = A*cos(2*pi*f0*t)

%Nfft = 2^nextpow2(length(xt))
Nfft = 10*N


spectre = fft(xt, Nfft)/N

spectre_ampl = abs(spectre)
sectre_phase = angle(spectre)

spectre_C = fftshift(spectre_ampl)

subplot(2,1,1);
stem(spectre_ampl)
xlabel("Frequence [0 fe] (Hz)")
ylabel("Spectre amplitude")

subplot(2,1,2); 
stem(spectre_C)
xlabel("Frequence [-fe/2 fe/2] (Hz)")
ylabel("Spectre amplitude")





%axis([0 100 -10 10]);
