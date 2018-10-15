clear;
close all;
load("Data.mat"); %on charge le fichier Data.mat


Te = 1/fe;
N = length(x1);
T = N*Te;
t = (0:1:N-1)*Te; %vecteur de temps associé avec t(1)=0, un pas de 1, pour finir à N-1, le tout *Te.

% 1)a)------------------------------------------------------------------------
%---------------------------------------------------------------------------
%-------------------------ANALYSE TEMPORELLE--------------------------------
%---------------------------------------------------------------------------
%Donnez la représentation temporelle du signal x1.
figure("name","analyse temporelle")
subplot(2,1,1);
plot(t,x1), xlabel("Temps (S)"), ylabel("Amplitude (V)"), title ("Signal Temporel x(t)");
hold on all
%Ici, on affiche le signal x1(t)

%---------------------------------------------------------------------------
%Que pouvez-vous dire sur les caractéristiques temporelles du signal ?

%Ceci est un signal analogique qui dure 04 secondes, d'amplutude max 30 V

%---------------------------------------------------------------------------
%Estimer la moyenne du signal. Ici, nous avons une moyenne égale à 10.01 V.
%Représenter cette valeur moyenne sur votre graphique:

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

% 1)b)-----------------------------------------------------------------------
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
stem(freq, abs(spectre_c)),xlabel("Frequence [-0.01 0.01] (Hz)"),ylabel("Amplitude (V)"),title("Spectre Amplitude sur [-1/2 1/2] zommé sur la raie centrale");
xlim([-.01 .01]);

%---------------------------------------------------------------------------
%Que pouvez-vous dire sur les caractéristiques fréquentielles du signal ?
% 
% Ici, nous voyons une raie de forte amplitude au milieu du signal, c'est
% la valeur moyenne de celui-ci.
%
%Les trois representations sont différentes car :
% -La première représente le signal sur une plage de fréquences [0 fe] soit
%  la Transformée de Fourrier de x1(n).
%
% -La seconde représente le signal sur une plage de fréquences [-fe/2 fe/2]
%  soit Transformée de Fourrier centrée de x1(n).
%
% -La troisieme représente le signal sur une plage de fréquences [-1/2 1/2]
%  soit Transformée de Fourrier centrée de x1(n) normalisé.
%
%Retrouve-t-on la moyenne du signal ?
%Oui, nous la retrouvons sur les deux derinères analyses spectrales soir
%sur [-fe/2 fe/2] et sur [-1/2 1/2]. La valeur moyenne du signal est
%l'amplitude de cette raie centrale.
% 
% 2)------------------------------------------------------------------------
%----------------------ANALYSE DE LA MOYENNE DU SIGNAL----------------------
%---------------------------------------------------------------------------

x2 = x1-mean(x1) ;
%Cette ligne de commande va retirer l'offest du signal x1, le signal x2
%devrait donc avoir une valeure moyenne nulle.

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
xlabel("Frequence [-fe/2 fe/2] (Hz)"),ylabel("Amplitude (V)"),title("Signal fréquenciel sur [-fe/2 fe/2]");

%En faisant cela, nous avons une raie centrale d'amplitude 0, c'est à dire
%que nous venons de supprimer cette raie.

%question bonus: dans la représentation fréquencielle, les fréquences de
%basse amplitudes représentent le bruit du signal. 
%Nous avons du bruit dit "stationnaire" ou "bruit blanc" (dans tout le domaine fréquenciel).
%Cela peut être dû à la méthode d'acquisition du signal (qualité du micro
%etc)
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


%b)Pourquoi ne retrouve-t-on pas exactement les fréquences du tableau ci-dessus ?
% Car nous avons ici un signal enregisté, les notes ne sont pas "pures".
%
% Résolution spectrale:
r = 1/(N*Te);
% r = 1/T = 1/(N*Te)
%
% Précision spectrale:
delta_f = fe/Nfft;
% delta_f = fe/Nfft
%
% Nous avons Résolution spectrale = Précision spectrale car dans notre cas: Nfft = N

%c)

Nbre_note = 8;
N_note = N/Nbre_note;
T_note = T/Nbre_note;

t_note = (0:1:N_note-1)*Te;

%d ) decoupage du signal en 8 blocs:

figure("name","Blocs signaux temporels")
for i = 1:8
    x_bloc = x2(floor(N_note*(i-1)+1:N_note*i));
    subplot(1,8,i);
    plot(t_note, x_bloc);
    title(['bloc ',num2str(i)]);
end

% Generation des FFT de chaque blocs:

figure("name","Blocs signaux fréquenciels")
for i = 1:8
    x_bloc = x2(floor(N_note*(i-1)+1:N_note*i));
    subplot(1,8,i);
    spectre = fft(x_bloc, Nfft)/N;
    spectre_c = fftshift(spectre);
    Nfft = length(spectre_c);
    freq = [-Nfft/2 : 1 : Nfft/2-1]*fe/Nfft;
    stem(freq, abs(spectre_c));
    title(['bloc ',num2str(i)]);
end


%On vient chercher la valeur de chaque raies chaque blocs (dans not recas à
% la main) 
% Ici, la séquence est (en Hz):392, 440, 494, 493.8, 440, 392, 440, 494
% puis on cherche a quelles notes elles correspondent;
% soit: ["sol","la","si","si","la","sol","la","si"]
 

%---------------------------GENERATEUR DE SIGNAL--------------------------
%Ici, nous venons generer notre nouveau signal avec des notes pures, il
%suffit de rentrer dans "partition" les notes "pures" voulues:

%Affichage des nouveaux blocs signaux:


figure("name","Signal reconstitué par blocs");
grandfinal = zeros(1,8);
partition = ["sol","la","si","si","la","sol","la","si"];
for i =1:8
    if (partition(i) == "sol")
        f0 = sol;
    elseif (partition(i) == "la")
        f0 = la;
    elseif (partition(i) == "si")
        f0 = si;
    elseif (partition(i) == "do")
        f0 = do;
    elseif (partition(i) == "re")
        f0 = re;
    else
    disp('Outch, y''a une erreur!');
    end
    subplot(8,1,i);
    playtime = cos(2*pi*f0*t_note);
    plot(t_note,playtime);
    grandfinal = [grandfinal, playtime];
end

%affichage du signal reconstitué "final"
figure("name","Signal reconstitué");
plot(grandfinal),xlabel("Temps(s)"),ylabel("Amplitude(V)"),title("Signal reconsitué");

%ecoute de l'ancien signal (avec bruit):
%sound(x2,fe);
%pause(5);

%ecoute du nouveau signal genere avec des notes "pures" (sans bruit):
sound(grandfinal,fe);
pause(5);


% iii) le titre pourrait être "frère jacque" ?

%---------------------------------------------------------------------------
figure("name","spectrogram");
spectrogram(x2,400,300,[],fe,'yaxis');

% Le spectrogramme est une représentation en un seul diagramme à deux 
%dimensions de trois paramètres:
% - La fréquence (axe Y)
% - Le temps (axe X)
% - La puissance/intensitée (couleurs)
% plus la couleur évolue vers le rouge plus l’intensité est importante
% On peut donc représenter de manière temporelle notre signal fréquenciel


%------------------------------------------------BONUS---------------------
%
%J'ai egalement essaye de generer la musique du theme de Mario en generant un signal qui contient des notes qui ont:
% -un t_note different (en fonction des donnes dans la liste "delay_ms")
% -une note differente (les notes se trouvent dans la liste "Tone1")
% 
%SOURCES DES DONNEES: https://gist.github.com/internalbuffer/749273f46309a83ddc5d17703392616c
%
% Decommenter le code ci-dessous pour lancer le theme de mario :
% %--------------------------------------------------------------------------


% %%%%%%%%%%%%%%%%%%%%%%%%%
% %%%THEME_DE_MARIO%%%%%%%%
% delays = [150,300,300,100,300,550,575,450,400,500,300,330,150,300,200,200,150,300,150,350,300,150,150,500,450,400,500,300,330,150,300,200,200,150,300,150,350,300,150,150,500,300,100,150,150,300,300,150,150,300,150,100,220,300,100,150,150,300,300,300,150,300,300,300,100,150,150,300,300,150,150,300,150,100,420,450,420,360,300,300,150,300,300,100,150,150,300,300,150,150,300,150,100,220,300,100,150,150,300,300,300,150,300,300,300,100,150,150,300,300,150,150,300,150,100,420,450,420,360,300,300,150,300,150,300,350,150,350,150,300,150,600,150,300,350,150,150,550,325,600,150,300,350,150,350,150,300,150,600,150,300,300,100,300,550,575];
% delays_ms = delays*0.001;
% Tone1 = [660,660,660,510,660,770,380,510,380,320,440,480,450,430,380,660,760,860,700,760,660,520,580,480,510,380,320,440,480,450,430,380,660,760,860,700,760,660,520,580,480,500,760,720,680,620,650,380,430,500,430,500,570,500,760,720,680,620,650,1020,1020,1020,380,500,760,720,680,620,650,380,430,500,430,500,570,585,550,500,380,500,500,500,500,760,720,680,620,650,380,430,500,430,500,570,500,760,720,680,620,650,1020,1020,1020,380,500,760,720,680,620,650,380,430,500,430,500,570,585,550,500,380,500,500,500,500,500,500,500,580,660,500,430,380,500,500,500,500,580,660,870,760,500,500,500,500,580,660,500,430,380,660,660,660,510,660,770,380];
% %%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% musique = zeros(1,(length(Tone1)));
% for i = 1: (length(Tone1));
%   N_note = ((delays_ms(i))*10^4)*2; % moduler le "2" pour la vitesse plus le 
%   t_note = (0:1:N_note-1)*Te;       % chiffre est elevé, plus les notes sont lentes
%    
%   f0 = Tone1(i);
%   note = cos(2*pi*f0*t_note);
%   musique = [musique, note]; 
% end
% 
% sound(musique,fe);

% %-------------------------------------------------------------------------------------------------------------------------
