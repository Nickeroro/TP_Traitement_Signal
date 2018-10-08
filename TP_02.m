tic;
clear;
close;
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

spectre_C1 = spectre(s1,N1,Nfft1);
spectre_C2 = spectre(s2,N2,Nfft2);

stem(freq1,spectre_C1)
hold on
stem(freq2,spectre_C2)

% Fréquence de coupure 
n = 10;
fc = fe2 / 2;
fcc = fc / fe1 * 2
h = fir1(n,fcc);
figure, freqz(h,1,fb,fe1), title(['FAR Avec ordre = ' num2str(n)]);

s1f = filter(h,1,s1);
spectre_C3 = spectre(s1f,N1,Nfft1);

figure, stem(freq1,spectre_C3)

s2f = filter(h,1,s2);
spectre4 = fft(s2, Nfft2)/N2;
spectre_ampl4 = abs(spectre4);
spectre_C4 = fftshift(spectre_ampl4);
  
figure, stem(freq2,spectre_C4)
