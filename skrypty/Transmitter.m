function [ txSignal ] = Transmitter(MOD, TXFILT, data, modulation)
    if strcmp(modulation, 'qpsk')
        modulatedSignal = step(MOD, data);
    elseif strcmp(modulation, '16qam')
        modulatedSignal = qammod(data,16,0);
    elseif strcmp(modulation, '64qam')
        modulatedSignal = qammod(data,64,0);
    end
    txSignal = step(TXFILT,modulatedSignal);
end

