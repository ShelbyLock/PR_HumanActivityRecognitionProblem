function GetTrnandTstDataForAllCases()
    types{1,1} = 'ap';
    types{1,2} = 'aw';
    types{1,3} = 'gp';
    types{1,4} = 'gw';
    
    scenarios{1,1} = 'A';
    scenarios{1,2} = 'B';
    scenarios{1,3} = 'C';
    for i = 1: 4
        type = types{1,i};
        fprintf("===Dataset %s Operation To Get TRN & TST Sets===\n", type);
        for j = 1: 3
            scenario = scenarios{1,j};
            fprintf("Get trn & tst for scenario %s\n", scenario);
            info = GETPNAMEinTrnTst(type, scenario);
            trnColnamesName = info.trnColnamesName;
            tstColnamesName = info.tstColnamesName;
            trnPath = info.trnPath;
            tstPath = info.tstPath;
            trnName = info.trnName;
            tstName = info.tstName;
            trnSetName = info.trnSetName;
            tstSetName = info.tstSetName;
            
            [data, colnames] = QueryOriginalData(type, scenario);
            [trn, tst] = TrnTstData(data);
            
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
    end
end