close all;
clear;
clc;
%%
MOD = comm.PSKModulator(4,pi/4);
DEMOD = comm.PSKDemodulator(4,pi/4);
TXFILT = comm.RaisedCosineTransmitFilter( ...
    'OutputSamplesPerSymbol',4);
RXFILT = comm.RaisedCosineReceiveFilter( ...
    'InputSamplesPerSymbol',4, ...
    'DecimationFactor',2);
DELAY = dsp.VariableFractionalDelay;
PFO = comm.PhaseFrequencyOffset(...
    'FrequencyOffset',1e4,...
    'PhaseOffset',20,...
    'SampleRate',1);
CARRSYNC = comm.CarrierSynchronizer( ...
    'SamplesPerSymbol', 2, 'Modulation', 'QPSK');
SYMSYNC = comm.SymbolSynchronizer('SamplesPerSymbol',2, ....
                                  'TimingErrorDetector', 'Mueller-Muller (decision-directed)');
                              % funkcja synchronizacji 'Mueller-Muller (decision-directed)' - parametr
%%
data = randi([0 3],1000,1);
modulatedSignal = step(MOD, data);
txSignal = step(TXFILT,modulatedSignal);

delayedSignal = step(DELAY,txSignal,1/5); % opoznienie 1/5 - parametr
offsetSignal = step (PFO, delayedSignal); 
rxSignal = awgn(offsetSignal,30,'measured');

rxSample = step(RXFILT,rxSignal);
rxCarrierSynchronized = step(CARRSYNC,rxSample);
rxSymbolSynchronized = step(SYMSYNC,rxCarrierSynchronized);
recivedSignal = step(DEMOD, rxSymbolSynchronized);
%%
% do koñca brzydkie hacki
% jesli probek wyjsciowych jest wiecej niz wejscia
if length(recivedSignal) < length(data)
    recivedSignal = [0; recivedSignal];
end
if length(recivedSignal) > length(data)
    recivedSignal = recivedSignal(2:end);
end
% przesuwamy wejscie o 11 lub 10, bo tak
error_rate = comm.ErrorRate('ReceiveDelay',11);
errors = step(error_rate,data,recivedSignal);
if errors(1) > 0.5
    error_rate = comm.ErrorRate('ReceiveDelay',10);
    errors = step(error_rate,data,recivedSignal);
end
results = errors(1)
%%
scatterplot(data)
scatterplot(modulatedSignal)
scatterplot(txSignal)
scatterplot(delayedSignal)
scatterplot(offsetSignal)
scatterplot(rxSignal)
scatterplot(rxSample)
scatterplot(rxCarrierSynchronized);
scatterplot(rxSymbolSynchronized)
scatterplot(recivedSignal)
