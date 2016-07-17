%% Teoretyczne próbkowanie sygna³u
Fs = 1000;                   % liczba próbek na sekundê
dt = 1/Fs;                   % co jaki czas rysuje próbkê
StopTime = 6*pi;              % d³ugoœæ osi X
t = (0:dt:StopTime-dt)';     % oœ X
%% Sinus
x = sin(t);
% Synga³ w czasie
figure;
hold on;
plot(t,x);
grid on;
xlim([0 6*pi])
ylim([-2 2])
xlabel('Czas [s]');
ylabel('Amplituda [mV]');
title('Wykres 1: Próbkowanie sygna³u niezniekszta³conego');
% Punkty próbkowania
x = t(1500:pi*1000:length(t));
y = sin(x);
stem(x,y, 'filled');
legend('Sygna³ sinusoidalny', 'Punkty próbkowania');
set(gca,'XTick',[pi/2 3*pi/2 5*pi/2 7*pi/2 9*pi/2 11*pi/2]);
hold off;

%% Sinus opóŸniony
r = linspace(0, -1, length(t));
x = sin(t+r');
% Synga³ w czasie
figure;
hold on;
plot(t,x);
grid on;
xlim([0 6*pi])
ylim([-2 2])
xlabel('Czas [s]');
ylabel('Amplituda [mV]');
title('Wykres 2: Próbkowanie sygna³u opóŸnionego');
% Punkty próbkowania
x = t(1500:pi*1000:length(t));
d = r(1500:pi*1000:length(t));
y = sin(x+d');
stem(x,y, 'filled');
legend('OpóŸniony sygna³ sinusoidalny', 'Punkty próbkowania');
set(gca,'XTick',[pi/2 3*pi/2 5*pi/2 7*pi/2 9*pi/2 11*pi/2]);
hold off;
