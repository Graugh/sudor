function [rxSample, rxCarrierSynchronized, rxSymbolSynchronized, recivedSignal] = Receiver(RXFILT, CARRSYNC, SYMSYNC, DEMOD, signal )
    rxSample = step(RXFILT,signal);
    rxCarrierSynchronized = step(CARRSYNC,rxSample);
    rxSymbolSynchronized = step(SYMSYNC,rxCarrierSynchronized);
    recivedSignal = step(DEMOD, rxSymbolSynchronized);
end

