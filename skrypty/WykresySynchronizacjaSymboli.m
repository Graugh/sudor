%% Teoretyczne pr�bkowanie sygna�u
Fs = 1000;                   % liczba pr�bek na sekund�
dt = 1/Fs;                   % co jaki czas rysuje pr�bk�
StopTime = 6*pi;              % d�ugo�� osi X
t = (0:dt:StopTime-dt)';     % o� X
%% Sinus
x = sin(t);
% Synga� w czasie
figure;
hold on;
plot(t,x);
grid on;
xlim([0 6*pi])
ylim([-2 2])
xlabel('Czas [s]');
ylabel('Amplituda [mV]');
title('Wykres 1: Pr�bkowanie sygna�u niezniekszta�conego');
% Punkty pr�bkowania
x = t(1500:pi*1000:length(t));
y = sin(x);
stem(x,y, 'filled');
legend('Sygna� sinusoidalny', 'Punkty pr�bkowania');
set(gca,'XTick',[pi/2 3*pi/2 5*pi/2 7*pi/2 9*pi/2 11*pi/2]);
hold off;

%% Sinus op�niony
r = linspace(0, -1, length(t));
x = sin(t+r');
% Synga� w czasie
figure;
hold on;
plot(t,x);
grid on;
xlim([0 6*pi])
ylim([-2 2])
xlabel('Czas [s]');
ylabel('Amplituda [mV]');
title('Wykres 2: Pr�bkowanie sygna�u op�nionego');
% Punkty pr�bkowania
x = t(1500:pi*1000:length(t));
d = r(1500:pi*1000:length(t));
y = sin(x+d');
stem(x,y, 'filled');
legend('Op�niony sygna� sinusoidalny', 'Punkty pr�bkowania');
set(gca,'XTick',[pi/2 3*pi/2 5*pi/2 7*pi/2 9*pi/2 11*pi/2]);
hold off;
