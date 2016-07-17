%% Zero-crossing - w�a�ciwe pr�bkowanie sygna�u
Fs = 1000;                   % liczba pr�bek na sekund�
dt = 1/Fs;                   % co jaki czas rysuje pr�bk�
StopTime = 2*pi;             % d�ugo�� osi X
t = (0:dt:StopTime-dt)';     % o� X
%% Sinus
x = sin(t);
% Synga� w czasie
figure;
hold on;
plot(t,x);
grid on;
xlim([0 2*pi])
ylim([-2 2])
xlabel('Czas [s]');
ylabel('Amplituda [mV]');
title('Wykres 3: Poprawne pr�bkowanie sygna�u z wykorzystaniem algorytmu Zero-Crossing');
% Punkty pr�bkowania
x = t(1575+pi*500:pi*500:length(t));
y = sin(x);
stem(x,y, 'filled');
legend('Sygna� sinusoidalny', 'Punkty pr�bkowania');
set(gca,'XTick',[pi/2 pi 3*pi/2]);
hold off;

%% Zero-crossing - pr�bkowanie zbyt wcze�nie
Fs = 1000;                   % liczba pr�bek na sekund�
dt = 1/Fs;                   % co jaki czas rysuje pr�bk�
StopTime = 6*pi;             % d�ugo�� osi X
t = (0:dt:StopTime-dt)';     % o� X
%% Sinus op�niony
r = linspace(0, -1, length(t));
x = sin(t+r');
% Synga� w czasie
figure;
hold on;
plot(t,x);
grid on;
xlim([0 2*pi])
ylim([-2 2])
xlabel('Czas [s]');
ylabel('Amplituda [mV]');
title('Wykres 4: Pr�bkowanie sygna�u op�nionego z wykorzystaniem algorytmu Zero-Crossing');
% Punkty pr�bkowania
x = t(1575+pi*500:pi*500:length(t));
d = r(1575+pi*500:pi*500:length(t));
y = sin(x+d');
stem(x,y, 'filled');
legend('Op�niony sygna� sinusoidalny', 'Punkty pr�bkowania');
set(gca,'XTick',[pi/2 pi 3*pi/2]);
set(gca,'YTick',[-0.97 0 0.18 1]);
hold off;