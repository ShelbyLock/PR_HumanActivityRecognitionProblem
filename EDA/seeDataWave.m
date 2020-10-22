function seeDataWave(data, filename1, filename2, filename3)
    minY = min(data.y);
    maxY = max(data.y);
    rangeY = minY : maxY;
    figure;
    tiledlayout(length(rangeY),1)
    for i = 1: length(rangeY)
        ax1 = nexttile;
        t = ['Class ' num2str(rangeY(i))];
        tempDataX = data.X(1:10, data.y == rangeY(i));
        plot(ax1, tempDataX);
        title(ax1, t)
        xlabel(ax1, 'Features From X0 to X10')
        ylabel(ax1, 'Value')
    end
    saveas(gcf,filename1);
    
    figure;
    tiledlayout(length(rangeY),1)
    for i = 1: length(rangeY)
        ax1 = nexttile;
        t = ['Class ' num2str(rangeY(i))];
        tempDataY = data.X(11:20, data.y == rangeY(i));       
        plot(ax1, tempDataY);
        title(ax1,t)
        xlabel(ax1, 'Features From Y0 to Y10');
        ylabel(ax1, 'Value');
    end
    saveas(gcf,filename2);
    
    figure;
    tiledlayout(length(rangeY),1)
    for i = 1: length(rangeY)
        ax1 = nexttile;
        t = ['Class ' num2str(rangeY(i))];
        tempDataZ = data.X(21:30, data.y == rangeY(i));
        plot(ax1, tempDataZ);
        title(ax1, t)
        xlabel(ax1, 'Features From Z0 to Z10');
        ylabel(ax1, 'Value');
    end
    saveas(gcf,filename3);
end