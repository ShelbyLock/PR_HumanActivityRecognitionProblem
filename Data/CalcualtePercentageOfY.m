function CalcualtePercentageOfY(targetDataset)
    type{1,1} = 'ap';
    type{1,2} = 'aw';
    type{1,3} = 'gp';
    type{1,4} = 'gw';
    for i = 1 : 4
        fprintf('========================================= \n');
        fprintf('======== Operation in Dataset %s ========\n', type{1,i});
        fprintf('========================================= \n');
        if targetDataset == 1
            data = loadOriginalData(type{1,i});
        else
            if targetDataset == 2
                data = loadTrnData(type{1,i});
                else
                    data = loadTstData(type{1,i});
            end
        end
        fprintf('**** %s check for Scenario A ****\n', type{1,i});
        checkYforA(data{1,1}.y);
        fprintf('**** %s check for Scenario B ****\n', type{1,i});
        checkYforB(data{1,2}.y);
        fprintf('**** %s check for Scenario C ****\n', type{1,i});
        checkYforC(data{1,3}.y);
    end
end
%check y in scenario A
function checkYforA(y)
    leny = length(y);
    sum0 = sum(y==1);
    sum1 = sum(y==2);
    sumall = sum0+sum1;
    assert (leny == (sumall));
    
    fprintf('---- Number of Data is %d ----\n', leny);
    fprintf('y == %d : percentage %.2f \n', 1, sum0/sumall);
    fprintf('y == %d : percentage %.2f \n', 2, sum1/sumall);
end

%check y in scenario B
function checkYforB(y)
    leny = length(y);
    sum1 = sum(y==1);
    sum2 = sum(y==2);
    sum3 = sum(y==3);
    sumall = sum1 + sum2 + sum3;
    assert (leny == sumall);
    
    fprintf('---- Number of Data is %d ----\n', leny);
    fprintf('y == %d : percentage %.2f \n', 1, sum1/sumall);
    fprintf('y == %d : percentage %.2f \n', 2, sum2/sumall);
    fprintf('y == %d : percentage %.2f \n', 3, sum3/sumall);
end

%check y in scenario C
function checkYforC(y)
    leny = length(y);
    sum1 = sum(y==1) + sum(y==2) + sum(y==3);
    sum2 = sum(y==4) + sum(y==5) + sum(y==6);
    sum3 = sum(y==7) + sum(y==8) + sum(y==9);
    sum4 = sum(y==10) + sum(y==11) + sum(y==12);
    sum5 = sum(y==13) + sum(y==14) + sum(y==15);
    sum6 = sum(y==16) + sum(y==17) + sum(y==18);
    sumall = sum1 + sum2 + sum3 + sum4 + sum5 + sum6;
    assert (leny == sumall);
    
    fprintf('---- Number of Data is %d ----\n', leny);
    allPer = 0;
    for i = 1: 18
        sumtemp = sum(y==i);
        currentPercent = sumtemp/sumall;
        fprintf('y == %d : percentage %.2f \n', i, currentPercent);
        allPer = allPer + currentPercent;
    end
end

function data = loadOriginalData(type)
    fprintf('-------- %s Check original Data --------\n',type);
    scenarios{1,1} = 'A';
    scenarios{1,2} = 'B';
    scenarios{1,3} = 'C';
    
    %Dummy Variables for checking Y
    data = cell(1,3);
    
    for i = 1 : 3
        scenario = scenarios{1,i};
        
        info = GETPNAMEinData(type, scenario);
        dataMatPath = info.dataMatPath;
        dataName = info.dataName;
        S = importdata(dataMatPath);
        data{1,i} = S.(dataName);
    end

end

function data = loadTrnData(type)
    fprintf('-------- %s Check Training Data --------\n',type);
    scenarios{1,1} = 'A';
    scenarios{1,2} = 'B';
    scenarios{1,3} = 'C';
    
    %Dummy Variables for checking Y
    data = cell(1,3);
    
    for i = 1 : 3
        scenario = scenarios{1,i};
        
        info = GETPNAMEinTrnTst(type, scenario);
        trnPath = info.trnPath;
        trnName = info.trnName;
        S = importdata(trnPath);
        data{1,i} = S.(trnName);
    end
end

function data = loadTstData(type)
    fprintf('-------- %s Check Testing Data --------\n',type);
    scenarios{1,1} = 'A';
    scenarios{1,2} = 'B';
    scenarios{1,3} = 'C';
    
    %Dummy Variables for checking Y
    data = cell(1,3);
    
    for i = 1 : 3
        scenario = scenarios{1,i};
        
        info = GETPNAMEinTrnTst(type, scenario);
        tstPath = info.tstPath;
        tstName = info.tstName;
        S = importdata(tstPath);
        data{1,i} = S.(tstName);
    end

end

