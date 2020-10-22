%Get Paths and Names in the GetTrnandTstDataForAllCases function 
function info = GETPNAMEinTrnTst(type, scenario)
    trnPath = ['./Data/' scenario '/TrainingTesting/' type scenario '_trn.mat'];
    tstPath = ['./Data/' scenario '/TrainingTesting/' type scenario '_tst.mat'];
    
    trnColnamesName = [type scenario '_tcolnames'];
    tstColnamesName = [type scenario '_scolnames'];
       
    trnName = [type scenario '_trn'];
    tstName = [type scenario '_tst'];
    
    trnSetName = [type ' TRN Scenario ' scenario];
    tstSetName = [type ' TST Scenario ' scenario];
    
    info.trnColnamesName = trnColnamesName;
    info.tstColnamesName = tstColnamesName;
    info.trnPath = trnPath;
    info.tstPath = tstPath;
    info.trnName = trnName;
    info.tstName = tstName;
    info.trnSetName = trnSetName;
    info.tstSetName = tstSetName;
end