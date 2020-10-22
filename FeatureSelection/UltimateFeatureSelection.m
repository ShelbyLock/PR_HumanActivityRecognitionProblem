function [trn, tst, colnames] = UltimateFeatureSelection(trn, tst, colnames, T2, info)
    featureNames = T2.Feature;
    newDimension = 30;
    
    if newDimension > trn.dim
        newDimension = trn.dim;
    end
    
    trn.dim = newDimension;
    tst.dim = newDimension;
    
    tempTrnX = zeros(newDimension,trn.num_data);
    tempTstX = zeros(newDimension,tst.num_data);
    new_colnames = strings([1,newDimension]);
    %delete features that are not in the top 40
    for i = 1 : newDimension
        currentFeatureName = featureNames(i);
        currentIndex = find(strcmp(colnames, currentFeatureName));

        tempTrnX(i,:) = trn.X(currentIndex,:);
        tempTstX(i,:) = tst.X(currentIndex,:);
        new_colnames(1,i) = colnames(currentIndex);
    end
    trn.X = tempTrnX;
    tst.X = tempTstX;
    colnames = new_colnames;
    
    trnColnamesName = info.trnColnamesName;
    tstColnamesName = info.tstColnamesName;
    trnPath = info.trnPath;
    tstPath = info.tstPath;
    trnName = info.trnName;
    tstName = info.tstName;
    trnSetName = info.trnSetName;
    tstSetName = info.tstSetName;            
            
    trn.name = trnSetName;
    tst.name = tstSetName;
            
    S1.(trnName) = trn;
    S1.(trnColnamesName) = colnames;
    S2.(tstName) = tst;
    S2.(tstColnamesName) = colnames;
    save(trnPath, '-struct', 'S1')
    save(tstPath, '-struct', 'S2')
            
    clear S1;
    clear S2;
end