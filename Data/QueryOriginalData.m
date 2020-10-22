function [data, colnames] = QueryOriginalData(type, scenario)
    info = GETPNAMEinData(type, scenario);
    dataMatPath = info.dataMatPath;
    colnamesName = info.colnamesName;
    dataName = info.dataName;
    
    Temp = importdata(dataMatPath);
    data = Temp.(dataName);
    colnames = Temp.(colnamesName);
end