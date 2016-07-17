%% Zero-crossing - w³aœciwe próbkowanie sygna³u
Fs = 1000;                   % liczba próbek na sekundê
dt = 1/Fs;                   % co jaki czas rysuje próbkê
StopTime = 2*pi;             % d³ugoœæ osi X
t = (0:dt:StopTime-dt)';     % oœ X
%% Sinus
x = sin(t);
% Synga³ w czasie
figure;
hold on;
plot(t,x);
grid on;
xlim([0 2*pi])
ylim([-2 2])
xlabel('Czas [s]');
ylabel('Amplituda [mV]');
title('Wykres 3: Poprawne próbkowanie sygna³u z wykorzystaniem algorytmu Zero-Crossing');
% Punkty próbkowania
x = t(1575+pi*500:pi*500:length(t));
y = sin(x);
stem(x,y, 'filled');
legend('Sygna³ sinusoidalny', 'Punkty próbkowania');
set(gca,'XTick',[pi/2 pi 3*pi/2]);
hold off;

%% Zero-crossing - próbkowanie zbyt wczeœnie
Fs = 1000;                   % liczba próbek na sekundê
dt = 1/Fs;                   % co jaki czas rysuje próbkê
StopTime = 6*pi;             % d³ugoœæ osi X
t = (0:dt:StopTime-dt)';     % oœ X
%% Sinus opóŸniony
r = linspace(0, -1, length(t));
x = sin(t+r');
% Synga³ w czasie
figure;
hold on;
plot(t,x);
grid on;
xlim([0 2*pi])
ylim([-2 2])
xlabel('Czas [s]');
ylabel('Amplituda [mV]');
title('Wykres 4: Próbkowanie sygna³u opóŸnionego z wykorzystaniem algorytmu Zero-Crossing');
% Punkty próbkowania
x = t(1575+pi*500:pi*500:length(t));
d = r(1575+pi*500:pi*500:length(t));
y = sin(x+d');
stem(x,y, 'filled');
legend('OpóŸniony sygna³ sinusoidalny', 'Punkty próbkowania');
set(gca,'XTick',[pi/2 pi 3*pi/2]);
set(gca,'YTick',[-0.97 0 0.18 1]);
hold off;