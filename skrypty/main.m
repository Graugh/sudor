close all;
clear;
clc;


    results = [];
    for i=1:1
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
        samplesPerSymbol = 2;
        CARRSYNC = comm.CarrierSynchronizer( ...
            'SamplesPerSymbol', samplesPerSymbol, 'Modulation', 'QPSK', 'NormalizedLoopBandwidth', 0.01, 'DampingFactor', 0.707);
        SYMSYNC = comm.SymbolSynchronizer('SamplesPerSymbol',samplesPerSymbol, ....
                                          'TimingErrorDetector', 'Mueller-Muller (decision-directed)');

        %%
        data = randi([0 3],1000,1);
        txSignal = Transmitter(MOD, TXFILT, data, 'qpsk');

        rxSignal = Channel(DELAY, PFO, txSignal, 1/5, 30); %... latency, snr)

        %% Receiver
        [rxSample, rxCarrierSynchronized, rxSymbolSynchronized, recivedSignal] = Receiver(RXFILT, CARRSYNC, ....
                                                                                        SYMSYNC, DEMOD, rxSignal, 'qpsk');

        %%
        acceptablePhaseError = 0.2;
        firstCorrectSymbol = NumberOfSampleWithAcceptableError( rxSymbolSynchronized, samplesPerSymbol, acceptablePhaseError );
        ber = ber_counter(data(firstCorrectSymbol:length(data)), recivedSignal(firstCorrectSymbol:length(recivedSignal)));


        i;
        results(i) = ber;
    end
%     acceptablePhaseError
    mean(results)
    

%%

scatterplot(rxSample);
title('Signal Before Synchronization');

scatterplot(rxCarrierSynchronized);
title('Signal After Carrier Synchronization');

scatterplot(rxSymbolSynchronized);
title('Signal After Symbol Synchronization');

colourfulConstellationDiagram(rxCarrierSynchronized, 'Signal After Carrier Synchronization')
colourfulConstellationDiagram(rxSymbolSynchronized, 'Signal After Symbol Synchronization')


% signalVisualisation(rxSample, 'Signal Before Carrier Synchronization')
signalVisualisation(rxCarrierSynchronized, 'Signal After Carrier Synchronization')
signalVisualisation(rxSymbolSynchronized, 'Signal After Symbol Synchronization')


PhaseError

