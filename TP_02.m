clear;
fe1 = 100000; %hz
fe2 = 10000;
Te1 = 1/fe1;
Te2 = 1/fe2;
fa = 3500;
fb = 7000;
T = 1;        %s
N1 = round(T / Te1);
N2 = round(T / Te2);
t1 = (0:1:N1-1)*Te1;
t2 = (0:1:N2-1)*Te2;

%Shannon OK fe1 > 2*fmax (7khz)
%Shannon not OK fe2 < 2*fmax (7khz) #repliement
s1 = cos(2*pi*fa*t1) + sin (2*pi*fb*t1);
s2 = cos(2*pi*fa*t2) + sin (2*pi*fb*t2);

Nfft1 = N1*10;
Nfft2 = N2*10;
freq1 = [-Nfft1/2:1:Nfft1/2-1]*fe1/Nfft1;
freq2 = [-Nfft2/2:1:Nfft2/2-1]*fe2/Nfft2;


spectre1 = fft(s1, Nfft1)/N1;
spectre_ampl1 = abs(spectre1);
spectre_C1 = fftshift(spectre_ampl1);

spectre2 = fft(s2, Nfft2)/N2;
spectre_ampl2 = abs(spectre2);
spectre_C2 = fftshift(spectre_ampl2);

stem(freq1,spectre_C1)
hold on
stem(freq2,spectre_C2)
