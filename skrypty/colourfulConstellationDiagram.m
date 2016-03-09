function colourfulConstellationDiagram(data, titleString)
    a = figure;
    set(a, 'Position', [379 200 420 420])
    scatter(real(data),imag(data),8,linspace(1,10,length(data)),'filled')
    title(titleString);
    xlabel('In-Phase')
    ylabel('Quadrature')
    axis([-1.6 1.6 -1.6 1.6])
    hold off
end

