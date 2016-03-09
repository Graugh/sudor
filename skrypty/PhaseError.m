samplesPhases = angle(rxCarrierSynchronized);

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
figure;
scatter(1:length(samplesPhases), samplesPhaseError, 8, 'filled')
xlabel('Samples')
ylabel('Phase [rad]')


