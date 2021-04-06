close all; clear all; % un peu de nettoyage 

T = 0.25 ;
M=32;
Te = T/M;
Tcont = Te/100; 
Tsim = T-Te;


Fsin = 60; % pour une fréquence de 4Hz
Res=sim('SimulDFT'); % Appelle le document simulink ? 

plot(Res.Sinus_Continu); % Trace la courbe continue 
hold on; % permet de superposer la courbe à suivre
plot(Res.Sinus_Echanti,'o'); % Trace la courbe échantillonée (les points)
grid; % rajoute une grille dans le schéma 

afterfft = fft(Res.Sinus_Echanti.data,M) / M; % on applique la fft sur la courbe échantillonée. 


x = linspace(0,M-1,M); % pour passer d'indice - 1-32 a 0-31
figure; % créé qqch 
plot(x,abs(afterfft),'o'); % dessine fft
grid ; 

vec_hert = x * Fsin;
figure; % créé qqch 
plot(vec_hert,abs(afterfft)); % fft fréquence en abs
grid ;
