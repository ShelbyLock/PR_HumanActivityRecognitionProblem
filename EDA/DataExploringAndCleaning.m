function [trn, tst, colnames, featureID, des, covPair] = DataExploringAndCleaning(trn, tst, colnames, info, shouldIPlot)
    %========================================================
    % Gain the first descriptive statistics result
    newinfo.desName = info.desBeforeName;
    newinfo.desXlsPath = info.desBeforeXlsPath;
    newinfo.desMatPath = info.desBeforeMatPath;
    des1 = DescriptiveStatsCalculation(trn, colnames, newinfo);
    
    featureID = 1: (length(colnames)-1);
    % get rid of errornous features
    [trn, tst, colnames, featureID, ~] = correlationStatsExamination(trn, tst, colnames, featureID, des1);
    
    if (shouldIPlot == 1)
        plotHistogramAndBoxplot(trn, colnames, featureID, info.vHistPathBefore, info.vBoxPathBefore)
        %seeDataWave(trn, info.vXTrendPathBefore, info.vYTrendPathBefore, info.vZTrendPathBefore);
    end
    close all;
    %Remove Outliners In trn.X and tst.X
    %trn.X = filloutliers(trn.X','linear','percentiles',[10 90])';
    %tst.X = filloutliers(tst.X','linear','percentiles',[10 90])';
       
    %======================================================== 
    % Gain the second descriptive statistics result
    %newinfo.desName = info.desProcessedName;
    %newinfo.desXlsPath = info.desProcessedXlsPath;
    %newinfo.desMatPath = info.desProcessedMatPath;
    %des2 = DescriptiveStatsCalculation(trn, colnames, newinfo);
    
    %Normalize Data
    trn = scaledstd(trn);
    tst = scaledstd(tst);
    if (shouldIPlot == 1)
        plotHistogramAndBoxplot(trn, colnames, featureID, info.vHistPathAfter, info.vBoxPathAfter)
        %seeDataWave(trn, info.vXTrendPathAfter, info.vYTrendPathAfter, info.vZTrendPathAfter);
    end
    close all;
    %======================================================== 
    % Gain the third descriptive statistics result
    newinfo.desName = info.desNrName;
    newinfo.desXlsPath = info.desNrXlsPath;
    newinfo.desMatPath = info.desNrMatPath;
    des = DescriptiveStatsCalculation(trn, colnames, newinfo);
    
    % get rid of errornous features again
    [trn, tst, colnames, featureID, covPair] = correlationStatsExamination(trn, tst, colnames, featureID, des);
end

function plotHistogramAndBoxplot(data, colnames, featureID, histName, boxPlotName)
    for i = 1: data.dim-1
        currentFeature = colnames(i);
        currentData = data.X(i,:)'; 
        
        newHistName = [histName ' ' currentFeature];
        newHistPath = strjoin([histName currentFeature '.fig'],'');
        
        histogram(currentData,'Normalization','pdf');
        title(newHistName)

        saveas(gcf,newHistPath);
        clear newhistName;
    end
    newboxPlotName = [boxPlotName '.fig'];
    C = num2cell(featureID); 
    boxplot(data.X(1:end-1,:)','Notch','on','Labels',C)
    xlabel('Feature Value')
    ylabel('Feature ID')
    title(newboxPlotName)
    saveas(gcf,newboxPlotName);
    clear newboxPlotName;
end