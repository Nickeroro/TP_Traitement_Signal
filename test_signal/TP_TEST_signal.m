clear;
close all;
load("test.mat"); %on charge le fichier Data.mat


Te = 1/fe;
N = length(x1);
T = N*Te;
t = (0:1:N-1)*Te; %vecteur de temps associ� avec t(1)=0, un pas de 1, pour finir � N-1, le tout *Te.

% 1)------------------------------------------------------------------------
%---------------------------------------------------------------------------
%-------------------------ANALYSE TEMPORELLE--------------------------------
%---------------------------------------------------------------------------
%Donnez la repr�sentation temporelle du signal x1.
figure("name","analyse temporelle")
subplot(2,1,1);
plot(t,x1), xlabel("Temps (S)"), ylabel("Amplitude (V)"), title ("Signal Temporel x(t)");
hold on all
%Ici, on affiche le signal x1(t)

%---------------------------------------------------------------------------
%Que pouvez-vous dire sur les caract�ristiques temporelles du signal ?
%Ne pas oublier de l�gender vos figures (commandes : xlabel(); et ylabel(); ).

%Ceci est un signal analogique qui dure xxx secondes, d'amplutude max xxx V

%---------------------------------------------------------------------------
%Estimer la moyenne du signal. 
%Repr�senter cette valeur moyenne sur votre graphique.

vect_mean = mean(x1).*ones(1, N);
plot(t,vect_mean),legend("signal x1","moyenne du signal x1");

%---------------------------------------------------------------------------
%ZOOM sur la plage [0 0.01]s:
subplot(2,1,2);
plot(t,x1), xlabel("Temps (S)"), ylabel("Amplitude (V)"), title ("Signal Temporel x1(t) sur la palge [0 0.01]s");
hold on all
plot(t,vect_mean),legend("signal x1","moyenne du signal x1");
xlim([0 0.01]);
hold off

%---------------------------------------------------------------------------
%-------------------------ANALYSE FREQUENCIELLE-----------------------------
%---------------------------------------------------------------------------
figure("name","Analyse Frequencielle");
% Spectre sur [0 ; fe]
Nfft = N;
spectre = fft(x1, Nfft)/N;
freq=[0:1:Nfft-1]*fe/Nfft;
subplot(4,1,1);
stem(freq, abs(spectre));
xlabel("Frequence [0 fe] (Hz)"),ylabel("Amplitude (V)"),title("Spectre Amplitude sur [0 fe]");

% Spectre sur [-fe/2 ; fe/2]
spectre_c = fftshift(spectre);
Nfft = length(spectre_c);
freq = [-Nfft/2 : 1 : Nfft/2-1]*fe/Nfft;
subplot(4,1,2);
stem(freq, abs(spectre_c));
xlabel("Frequence [-fe/2 fe/2] (Hz)"),ylabel("Amplitude (V)"),title("Spectre Amplitude sur [-fe/2 fe/2]");

% Spectre sur [-1/2 ; 1/2]
spectre_c = fftshift(spectre);
Nfft = length(spectre_c);
freq = ([-Nfft/2 : 1 : Nfft/2-1]*fe/Nfft)/fe;
subplot(4,1,3);
stem(freq, abs(spectre_c)),xlabel("Frequence [-1/2 1/2] (Hz)"),ylabel("Amplitude (V)"),title("Spectre Amplitude sur [-1/2 1/2]");

subplot(4,1,4);
stem(freq, abs(spectre_c)),xlabel("Frequence [-0.01 0.01] (Hz)"),ylabel("Amplitude (V)"),title("Spectre Amplitude sur [-1/2 1/2] zomm� sur la raie centrale");
xlim([-.01 .01]);

%---------------------------------------------------------------------------
%Que pouvez-vous dire sur les caract�ristiques fr�quentielles du signal ?
% 
% PARLER DES RAIES APPARENTES !!!!!!!!!!!!!!
%
%Les trois representations sont diff�rentes car :
% -La premi�re repr�sente le signal sur une plage de fr�quences [0 fe] soit
%  la Transform�e de Fourrier de x1(n).
%
% -La seconde repr�sente le signal sur une plage de fr�quences [-fe/2 fe/2]
%  soit Transform�e de Fourrier centr�e de x1(n).
%
% -La troisieme repr�sente le signal sur une plage de fr�quences [-1/2 1/2]
%  soit Transform�e de Fourrier centr�e de x1(n) normalis�.
%
%Retrouve-t-on la moyenne du signal ?
%Oui, nous la retrouvons sur les deux derin�res analyses spectrales soir
%sur [-fe/2 fe/2] et sur [-1/2 1/2]. La valeur moyenne du signal est
%l'amplitude de cette raie centrale.
% 
% 2)------------------------------------------------------------------------
%----------------------ANALYSE DE LA MOYENNE DU SIGNAL----------------------
%---------------------------------------------------------------------------

x2 = x1-mean(x1) ;
%cette ligne de commande viens retirer l'offest du signal x1, le signal x2
%devrait donc avoir une vlaur moyenne nulle.

figure("name","analyse de ma moyenne du signal")
subplot(2,1,1);
plot(t,x2), xlabel("Temps (S)"), ylabel("Amplitude (V)"), title ("Signal Temporel x2(t)");
hold on
vect_mean2 = mean(x2).*ones(1, N);
plot(t,vect_mean2),legend("signal x2","moyenne du signal x2");
hold off

subplot(2,1,2);
spectre = fft(x2, Nfft)/N;
spectre_c = fftshift(spectre);
Nfft = length(spectre_c);
freq = [-Nfft/2 : 1 : Nfft/2-1]*fe/Nfft;
stem(freq, abs(spectre_c));
xlabel("Frequence [-fe/2 fe/2] (Hz)"),ylabel("Amplitude (V)"),title("Signal fr�quenciel sur [-fe/2 fe/2]");

%En faisant cela, nous avons une raie centrale d'amplitude 0, c'est � dire
%que nous venons de supprimer cette raie.

%question bonus: dans la repr�sentation fr�quencielle, les fr�quences de
%basse amplitudes repr�sentent le bruit du signal. 
%Nous avons du bruit dit "stationnaire" ou "bruit blanc".

% 3)------------------------------------------------------------------------
%---------------------------ANALYSE FINE DU SIGNAL--------------------------
%---------------------------------------------------------------------------

sol = 391.99;
la = 440;
si = 493.88;
do = 523.25;
re = 587.32;

%a)
figure("name","analyse fine du signal")
subplot(5,1,1);
spectre = fft(x2, Nfft)/N;
spectre_c = fftshift(spectre);
Nfft = length(spectre_c);
freq = [-Nfft/2 : 1 : Nfft/2-1]*fe/Nfft;
stem(freq, abs(spectre_c));
xlabel("Frequence [sol-10 sol+10] (Hz)"),ylabel("Amplitude (V)"),title("Note: SOL");
xlim([(sol-10) (sol+10)]);

subplot(5,1,2);
stem(freq, abs(spectre_c));
xlabel("Frequence [la-10 la+10] (Hz)"),ylabel("Amplitude (V)"),title("Note: LA");
xlim([(la-10) (la+10)]);

subplot(5,1,3);
stem(freq, abs(spectre_c));
xlabel("Frequence [si-10 si+10] (Hz)"),ylabel("Amplitude (V)"),title("Note: SI");
xlim([(si-10) (si+10)]);

subplot(5,1,4);
stem(freq, abs(spectre_c));
xlabel("Frequence [do-10 do+10] (Hz)"),ylabel("Amplitude (V)"),title("Note: DO");
xlim([(do-10) (do+10)]);

subplot(5,1,5);
stem(freq, abs(spectre_c));
xlabel("Frequence [re-10 re+10] (Hz)"),ylabel("Amplitude (V)"),title("Note: RE");
xlim([(re-10) (re+10)]);


%b)Pourquoi ne retrouve-t-on pas exactement les fr�quences du tableau ci-dessus ?
% Car nous avons ici un signal enregist�, les notes ne sont pas "pures".
%
% R�solution spectrale:
r = 1/(N*Te);
% r = 1/T = 1/(N*Te)
%
% Pr�cision spectrale:
delta_f = fe/Nfft;
% delta_f = fe/Nfft
%
% Nous avons le m�me r�sultat car dans notre cas: Nfft = N

%c)

Nbre_note = 8;
%T = 4; %attention
N_note = N/Nbre_note;
T_note = T/Nbre_note;

t_note = (0:1:N_note-1)*Te;

%d )
figure("name","Blocs signaux temporels")
for i = 1:8
    x_bloc = x2(floor(N_note*(i-1)+1:N_note*i));
    subplot(1,8,i);
    plot(t_note, x_bloc);
    title(['bloc',num2str(i)]);
end

figure("name","Blocs signaux fr�quenciels")
for i = 1:8
    x_bloc = x2(floor(N_note*(i-1)+1:N_note*i));
    subplot(1,8,i);
    spectre = fft(x_bloc, Nfft)/N;
    spectre_c = fftshift(spectre);
    Nfft = length(spectre_c);
    freq = [-Nfft/2 : 1 : Nfft/2-1]*fe/Nfft;
    stem(freq, abs(spectre_c));
    title(['bloc',num2str(i)]);
end

%figure()
% partition = ["sol", "la", "si", "do", "re", "sol", "la", "si"];
% for i =1:8
%     if (partition(i) == "sol")
%         f0 = sol;
%     elseif (partition(i) == "la")
%         f0 = la;
%     elseif (partition(i) == "si")
%         f0 = si;
%     elseif (partition(i) == "do")
%         f0 = do;
%     elseif (partition(i) == "re")
%         f0 = re;
%     else
%     disp('Outch, y''a une erreur!');
%     end
%     %subplot(1,8,i);
%     playtime = cos(2*pi*f0*t_note);
%     %plot(t_note, playtime)
%     Ai = ia_time(i) + arrival;
%     son = [playtime]
%     plot(playtime)
% end
%sound(x1,fe)

figure();
signalfinal = [cos(2*pi*la*t_note) cos(2*pi*re*t_note) cos(2*pi*si*t_note) cos(2*pi*do*t_note)];
plot(signalfinal);

sound(signalfinal,fe);


figure("name","spectrogram");
spectrogram(x2,400,300,[],fe,'yaxis');

% Le spectrogramme est une repr�sentation en un seul diagramme � deux 
%dimensions de trois param�tres:
% - La fr�quence (axe Y)
% - Le temps (axe X)
% - La puissance/intensit�e (couleurs)
% plus la couleur �volue vers le rouge plus l�intensit� est importante
% On peut donc repr�senter de mani�re temporelle notre signal fr�quenciel

