function signalVisualisation(samples, titleString)
    figure;
    plot(1:length(imag(samples)+real(samples)), imag(samples)+real(samples), 'b');
    title(titleString);
end

