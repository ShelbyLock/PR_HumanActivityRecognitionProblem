function [S] = LoadSavedOriginalData()
    types{1,1} = 'ap';
    types{1,2} = 'aw';
    types{1,3} = 'gp';
    types{1,4} = 'gw';
    
    scenarios{1,1} = 'A';
    scenarios{1,2} = 'B';
    scenarios{1,3} = 'C';
    for i = 1 : 4
        type = types{1,i};
         for j = 1 : 3
             scenario = scenarios{1,j};
             
             info = GETPNAMEinData(type, scenario);          
             dataMatPath = info.dataMatPath;
             colnamesName = info.colnamesName;
             dataName = info.dataName;
             
             Temp = importdata(dataMatPath);
             S.(dataName) = Temp.(dataName);
             S.(colnamesName) = Temp.(colnamesName);
         end
    end
end



