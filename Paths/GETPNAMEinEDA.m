%PathsAndNames
%Get Paths and Names for functions in EDA
function info = GETPNAMEinEDA(type, scenario)
     desPath = ['./EDA/' scenario '/DescriptiveStats/'];
     vPath = './EDA/Visualization/';
     dataPath = ['./Data/' scenario '/FeatureSelection/'];
     
     %Paths for the files that store the descriptive analysis result
     desBeforeMatPath = [desPath type scenario '_des_before.mat'];
     desBeforeXlsPath = [desPath type scenario '_des_before.xlsx'];
     desProcessedMatPath = [desPath type scenario '_des_processed.mat'];
     desProcessedXlsPath = [desPath type scenario '_des_processed.xlsx'];
     desNrMatPath = [desPath type scenario '_des_nr.mat'];
     desNrXlsPath = [desPath type scenario '_des_nr.xlsx'];
     
     desBeforeName = [type scenario '_des_before'];
     desProcessedName = [type scenario '_des_processed'];
     desNrName = [type scenario '_des_nr'];
     
     %Paths for visualization
     vBoxPathBefore = [vPath type '/Boxplot/Before/' type 'BoxPlot_before'];
     vHistPathBefore = [vPath type '/Histogram/Before/' type 'Histogram_before'];
     vPatternBefore = [vPath type '/Pattern/Before/' type 'Pattern_before'];
     
     vXTrendPathBefore = [vPath type '/Trend/Before/' type 'XTrend_before'];
     vYTrendPathBefore = [vPath type '/Trend/Before/' type 'YTrend_before'];
     vZTrendPathBefore = [vPath type '/Trend/Before/' type 'ZTrend_before'];
     
     vBoxPathAfter = [vPath type '/Boxplot/After/' type 'BoxPlot_after'];
     vHistPathAfter = [vPath type '/Histogram/After/' type 'Histogram_after'];
     vPatternAfter = [vPath type '/Pattern/After/' type 'Pattern_after'];
     
     vXTrendPathAfter = [vPath type '/Trend/After/' type 'XTrend_after'];
     vYTrendPathAfter = [vPath type '/Trend/After/' type 'YTrend_after'];
     vZTrendPathAfter = [vPath type '/Trend/After/' type 'ZTrend_after'];
     %Path for storing Trn and Tst data after feature selection
     trnPath = [dataPath type scenario 'trn.mat'];
     tstPath = [dataPath type scenario 'tst.mat'];
     trnColnamesName = [type scenario '_tcolnames'];
     tstColnamesName = [type scenario '_scolnames'];
       
     trnName = [type scenario '_trn'];
     tstName = [type scenario '_tst'];
    
     trnSetName = [type ' Trn Data After Feature Selection Scenario' scenario];
     tstSetName = [type ' Tst Data After Feature Selection Scenario' scenario];

     %des
     info.desBeforeName = desBeforeName;
     info.desBeforeMatPath = desBeforeMatPath;
     info.desBeforeXlsPath = desBeforeXlsPath;
     
     info.desProcessedName = desProcessedName;
     info.desProcessedMatPath = desProcessedMatPath;
     info.desProcessedXlsPath = desProcessedXlsPath;
     
     info.desNrName = desNrName;
     info.desNrMatPath = desNrMatPath;
     info.desNrXlsPath = desNrXlsPath;
     
     %Plots
     info.vBoxPathBefore = vBoxPathBefore;
     info.vHistPathBefore = vHistPathBefore;
     info.vBoxPathAfter = vBoxPathAfter;
     info.vHistPathAfter = vHistPathAfter;     
     info.vPatternBefore = vPatternBefore;
     info.vPatternAfter = vPatternAfter;
     
     info.vXTrendPathBefore = vXTrendPathBefore;
     info.vYTrendPathBefore = vYTrendPathBefore;
     info.vZTrendPathBefore = vZTrendPathBefore;
     
     info.vXTrendPathAfter = vXTrendPathAfter;
     info.vYTrendPathAfter = vYTrendPathAfter;
     info.vZTrendPathAfter = vZTrendPathAfter;
     
     %data
     info.trnPath = trnPath;
     info.tstPath = tstPath;
     info.trnColnamesName = trnColnamesName;
     info.tstColnamesName = tstColnamesName;
     info.trnName = trnName;
     info.tstName = tstName;
     info.trnSetName = trnSetName;
     info.tstSetName = tstSetName;     
end