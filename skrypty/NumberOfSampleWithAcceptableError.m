function [ expectedNumberOfSample ] = NumberOfSampleWithAcceptableError( samples, samplesPerSymbol, acceptableError)
%     acceptableError = 0.2; %[rad]
    samplesPhases = angle(samples);


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
    
    for i=1:length(samplesPhaseMeanError)
        try
            if CheckIfGivenValuesAreSmallerOrEqualThanExpected(samplesPhaseMeanError(i:i+10), acceptableError) == 1
                expectedNumberOfSample = i;
                break
            end
        catch
        end
    end
    expectedNumberOfSample = ceil(expectedNumberOfSample/samplesPerSymbol);
end

