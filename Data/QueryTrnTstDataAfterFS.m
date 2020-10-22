function [trn, tcolnames, tst, scolnames] = QueryTrnTstDataAfterFS(type, scenario)
    info = GETPNAMEinFS(type, scenario);
    trnColnamesName = info.trnColnamesName;
    tstColnamesName = info.tstColnamesName;
    trnPath = info.trnPath;
    tstPath = info.tstPath;
    trnName = info.trnName;
    tstName = info.tstName;
    
    Temp = importdata(trnPath);
    trn = Temp.(trnName);
    tcolnames = Temp.(trnColnamesName);
    
    Temp = importdata(tstPath);
    tst = Temp.(tstName);
    scolnames = Temp.(tstColnamesName);
end