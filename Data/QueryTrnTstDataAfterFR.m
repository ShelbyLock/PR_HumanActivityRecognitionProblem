function [trn, tst] = QueryTrnTstDataAfterFR(type, scenario, reductionModel, dim)
    info = GETPNAMEinFR(type, scenario, reductionModel, dim);
    trnPath = info.trnPath;
    tstPath = info.tstPath;
    
    if length(trnPath) > 1
        trnPath = strjoin(trnPath, '');
        tstPath = strjoin(tstPath, '');
    end
    trn = importdata(trnPath);
    tst = importdata(tstPath);
end