%PathsAndNames
%Get Paths and Names for functions in feature selection
function info = GETPNAMEinFS(type, scenario)
     rankPath = ['./FeatureSelection/' scenario '/RankStats/'];
     dataPath = ['./Data/' scenario '/FeatureSelection/'];
     
     %Path for feature ranking before redundant features removal
     rankPathBefore = [rankPath type scenario '_rank_before.mat'];
     %Path for feature ranking after redundant features removal
     rankPathAfter = [rankPath type scenario '_rank_after.mat'];
     rankPathDeleteRecord = [rankPath type scenario '_rank_deleteRecord.mat'];
     
     %Path for storing Trn and Tst data after feature selection
     trnPath = [dataPath type scenario 'trn.mat'];
     tstPath = [dataPath type scenario 'tst.mat'];
     trnColnamesName = [type scenario '_tcolnames'];
     tstColnamesName = [type scenario '_scolnames'];
       
     trnName = [type scenario '_trn'];
     tstName = [type scenario '_tst'];
    
     trnSetName = [type ' Trn Data After Feature Selection Scenario' scenario];
     tstSetName = [type ' Tst Data After Feature Selection Scenario' scenario];
     
     %rank
     info.rankPathBefore = rankPathBefore;
     info.rankPathAfter = rankPathAfter;
     info.rankPathDeleteRecord = rankPathDeleteRecord;
     
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