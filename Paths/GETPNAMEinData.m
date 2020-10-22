%PathsAndNames
%Get Paths and Names in the GetandSaveDataForAllCases() function
function info = GETPNAMEinData(type, scenario)
     dataPath = ['./Data/' scenario '/OriginalData/'];
     
     dataMatPath = [dataPath type scenario '.mat'];
     dataXlsPath = [dataPath type scenario '.xlsx'];
     
     colnamesName = [type '_colnames' scenario];
     
     dataName = [type '_data' scenario];        
     dataSetName = [type ' Data Scenario' scenario];
    
     info.dataMatPath = dataMatPath;
     info.dataXlsPath = dataXlsPath;
     info.colnamesName = colnamesName;
     info.dataName = dataName;
     info.dataSetName = dataSetName;
end