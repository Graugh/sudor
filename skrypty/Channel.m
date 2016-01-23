function [ outputSignal ] = Channel(DELAY, PFO, signal, latency, snr)
    delayedSignal = step(DELAY, signal, latency); % opoznienie 1/5 - parametr
    offsetSignal = step (PFO, delayedSignal); 
    outputSignal = awgn(offsetSignal, snr, 'measured');
end

