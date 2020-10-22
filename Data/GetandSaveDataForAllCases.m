function GetandSaveDataForAllCases()

    type{1,1} = 'ap';
    type{1,2} = 'aw';
    type{1,3} = 'gp';
    type{1,4} = 'gw';

    prefix{1,1} = './arff_files/phone/accel/data_16';
    prefix{1,2} = './arff_files/watch/accel/data_16';
    prefix{1,3} = './arff_files/phone/gyro/data_16';
    prefix{1,4} = './arff_files/watch/gyro/data_16';

    suffix{1,1} = '_ACCEL_PHONE.arff';
    suffix{1,2} = '_ACCEL_WATCH.arff';
    suffix{1,3} = '_GYRO_PHONE.arff';
    suffix{1,4} = '_GYRO_WATCH.arff';

    for i = 1 : 4
        GetandSaveData(prefix{1,i}, suffix{1,i}, type{1,i})
    end
end

function GetandSaveData(prefix, suffix, type)
    fprintf("===Dataset %s Operation===\n", type);
    % Get data struct
    [colnames, dataA, dataB, dataC] = DataStruct(prefix, suffix);
    
    scenarios{1,1} = 'A';
    scenarios{1,2} = 'B';
    scenarios{1,3} = 'C';
    
    % Define Paths and Names
    DATA = cell(1,3);
    DATA{1,1} = dataA;
    DATA{1,2} = dataB;
    DATA{1,3} = dataC;
    
    for i = 1 : 3
        scenario = scenarios{1,i};
        fprintf("Get data for scenario %s\n", scenario);
        
        info = GETPNAMEinData(type, scenario);
        dataMatPath = info.dataMatPath;
        
        dataXlsPath = info.dataXlsPath;
        colnamesName = info.colnamesName;
        dataName = info.dataName;
        dataSetName = info.dataSetName;
        
        DATA{1,i}.name = dataSetName;
        
        % Save the acquired data struct in the mat form
        S.(colnamesName) = colnames;
        S.(dataName) = DATA{1,i};
    
        save(dataMatPath,'-struct', 'S');
        clear S;
        
        % Save the acquired data struct in the xlsx form
        %T = array2table(DATA{1,i}.X',...
        'VariableNames',colnames);

        %writetable(T,dataXlsPath,'Sheet',1)
    end

end

