MOD = comm.PSKModulator(4,pi/4);
DEMOD = comm.PSKDemodulator(4,pi/4);
TXFILT = comm.RaisedCosineTransmitFilter( ...
    'OutputSamplesPerSymbol',4);
RXFILT = comm.RaisedCosineReceiveFilter( ...
    'InputSamplesPerSymbol',4, ...
    'DecimationFactor',2);
DELAY = dsp.VariableFractionalDelay;
SYMSYNC = comm.SymbolSynchronizer('SamplesPerSymbol',2, ....
                                  'TimingErrorDetector', 'Mueller-Muller (decision-directed)');
                              % funkcja synchronizacji 'Mueller-Muller (decision-directed)' - parametr

data = randi([0 3],1000,1);
modSig = step(MOD, data);
txSig = step(TXFILT,modSig);
delaySig = step(DELAY,txSig,1/5); % opoznienie 1/5 - parametr
rxSig = awgn(delaySig,30,'measured');
rxSample = step(RXFILT,rxSig);
rxSync = step(SYMSYNC,rxSample);
recv = step(DEMOD, rxSync);

% do koñca brzydkie hacki
% jesli probek wyjsciowych jest wiecej niz wejscia
if length(recv) < length(data)
    recv = [0; recv];
end
if length(recv) > length(data)
    recv = recv(2:end);
end
% przesuwamy wejscie o 11 lub 10, bo tak
error_rate = comm.ErrorRate('ReceiveDelay',11);
errors = step(error_rate,data,recv);
if errors(1) > 0.5
    error_rate = comm.ErrorRate('ReceiveDelay',10);
    errors = step(error_rate,data,recv);
end
results = errors(1);
% scatterplot(data)
% scatterplot(modSig)
% scatterplot(txSig)
% scatterplot(delaySig)
% scatterplot(rxSig)
% scatterplot(rxSample)
% scatterplot(rxSync)
% scatterplot(recv)
