function [rxSample, rxCarrierSynchronized, rxSymbolSynchronized, recivedSignal] = Receiver(RXFILT, CARRSYNC, SYMSYNC, DEMOD, signal, modulation, cycleSlip )
    rxSample = step(RXFILT,signal);
    if cycleSlip ~= 0
        a1=rxSample(1:500*cycleSlip-1);
        a2=rxSample(500*cycleSlip+1:2000);
        rxSample=vertcat(a1, a2);
    end
    rxCarrierSynchronized = step(CARRSYNC,rxSample);
    rxSymbolSynchronized = step(SYMSYNC,rxCarrierSynchronized);
    if strcmp(modulation,'qpsk')
        recivedSignal = step(DEMOD, rxSymbolSynchronized);
    elseif strcmp(modulation,'16qam')
        recivedSignal = qamdemod(rxSymbolSynchronized,16);
    elseif strcmp(modulation,'64qam')
        recivedSignal = qamdemod(rxSymbolSynchronized,64);
    end
end

