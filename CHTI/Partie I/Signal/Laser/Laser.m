close all; clear all; % un peu de nettoyage 

T = 1/5000 ;
Fe = 320000;
Te = 1/Fe;
M=(Fe*T); % critère de Shannon

F1 = 85005,9 ; 
F2 = 90000 ; 
F3 = 94986,8 ; 
F4 = 100000 ;
F5 = 115015,9 ; 
F6 = 120000 ; 

F11 = 85000;
Res=sim('Laser_test'); % Appelle le document simulink ? 

%plot(Res.Signal);

for c = 1:20
    Res.Signal.Data(c) = 0;
end

%ResF = fft(Res.Signal.Data,M)/M;

ResF = fft(Res.Carre_sign.Data,M)/M;

figure;
x = linspace(0,M-1,M);
f=1/T*x;
semilogy(f,abs(ResF),'o');

Fp = tf([1], [1.7483*10^-23 7.6663*10^-18 1.162e-11 3.0332e-6 1]);
bode(Fp);


