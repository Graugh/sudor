acceptableError = 0.2; %[rad]

% samplesPhases = angle(rxCarrierSynchronized);
samplesPhases = angle(rxSymbolSynchronized);

figure;
scatter(1:length(samplesPhases),samplesPhases,8, 'filled')
xlabel('Samples')
ylabel('Phase')
hold on;
plot(1:length(samplesPhases), ones(1,length(samplesPhases))*pi/4,'k')
plot(1:length(samplesPhases), ones(1,length(samplesPhases))*3*pi/4,'k')
plot(1:length(samplesPhases), ones(1,length(samplesPhases))*-1*pi/4,'k')
plot(1:length(samplesPhases), ones(1,length(samplesPhases))*-3*pi/4,'k')
hold off;

samplesPhaseError = [];
for i=1:length(samplesPhases)
    if samplesPhases(i) > pi/2
        samplesPhaseError(i) = samplesPhases(i) - pi/2;
    elseif samplesPhases(i) < 0 && samplesPhases(i) >= -pi/2
        samplesPhaseError(i) = samplesPhases(i) + pi/2;
    elseif samplesPhases(i) < -pi/2
        samplesPhaseError(i) = samplesPhases(i) + pi;
    else
        samplesPhaseError(i) = samplesPhases(i);
    end
end

samplesPhaseError = abs(samplesPhaseError - pi/4); %*180/pi;
samplesPhaseMeanError = [];
numberOfSamplesToMeanError = 50;
for i=1:length(samplesPhases)
    if i > numberOfSamplesToMeanError
        samplesPhaseMeanError(i) = mean(samplesPhaseError(i-numberOfSamplesToMeanError:i));
    else
        samplesPhaseMeanError(i) = mean(samplesPhaseError(1:i));
    end                
end

for i=1:length(samplesPhases)
    try
        if CheckIfGivenValuesAreHigherOrEqualThanExpected(samplesPhaseMeanError(i,i+10), acceptableError) == 1
            numberOfSampleWithacceptableError = i;
            break
        end
    catch
    end
end
            

figure;
% scatter(1:length(samplesPhaseMeanError), samplesPhaseMeanError, 8, 'filled')
plot(1:length(samplesPhaseMeanError), samplesPhaseMeanError);
xlabel('Samples')
ylabel('Phase [rad]')


