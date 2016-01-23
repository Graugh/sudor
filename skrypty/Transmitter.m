function [ txSignal ] = Transmitter(MOD, TXFILT, data)
    modulatedSignal = step(MOD, data);
    txSignal = step(TXFILT,modulatedSignal);
end

