function [rxSample, rxCarrierSynchronized, rxSymbolSynchronized, recivedSignal] = Receiver(RXFILT, CARRSYNC, SYMSYNC, DEMOD, signal, modulation )
    rxSample = step(RXFILT,signal);
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

