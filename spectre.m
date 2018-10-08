function [spectre_C]= spectre(s,N,Nfft )

spectre = fft(s, Nfft)/N;
spectre_ampl = abs(spectre);
spectre_C = fftshift(spectre_ampl);

end
