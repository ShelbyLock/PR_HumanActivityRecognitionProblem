function Classification()
    types{1,1} = 'ap';
    types{1,2} = 'aw';
    types{1,3} = 'gp';
    types{1,4} = 'gw';
    
    scenarios(1) = 'A'; %Scenario A
    scenarios(2) = 'B'; %Scenario B
    scenarios(3) = 'C'; %Scenario C
    
    classificationMethod{1,1} = 'FisherLDA';
    classificationMethod{1,2} = 'MDC';
    classificationMethod{1,3} = 'KNN';
    classificationMethod{1,4} = 'Bayes';
    classificationMethod{1,5} = 'SVM';
   
    for i = 1 : length(types)    
        type = types{1,i};
        for i2 = 1 : length(scenarios)
            scenario = scenarios(i2);
            % get the maximum Dimension
            [trn_temp, ~, ~, ~] = QueryTrnTstDataAfterFS(type, scenario);
            maxdim = trn_temp.dim;  
            fprintf("========================================\n");
            fprintf("Test Classifiers for Type %s Scenario %s\n", type, scenario);
            fprintf("========================================\n");
            for j = length(classificationMethod)
                cuttentC = classificationMethod{1,j};
                fprintf("====Curent Classifier %s\n", cuttentC);
                PerformClassification(type, scenario, cuttentC, maxdim);     
            end
        end
    end
end

function PerformClassification(type, scenario, currentC, maxdim)
    featureRecutionMethod{1,1} = 'PCA';
    featureRecutionMethod{1,2} = 'LDA';
    featureRecutionMethod{1,3} = 'LDA_PCA';  
    
    %Get the path for recording the training and testing stats
    info = GETPNAMEForClassifiersRecord(type, scenario, currentC);
    recordFilename = info.recordFilename;
    recordName = info.recordName;
    
    %Initialize the record
    
    numofRecord = ceil(maxdim/2) * length(featureRecutionMethod);
    
    RowCount = zeros(numofRecord,1);
    RunCount = zeros(numofRecord,1);
    ClassificationModel = strings([numofRecord 1]);
    ReductionModel = strings([numofRecord 1]);
    Dimension = zeros(numofRecord,1);
    TrainingAccuracy = zeros(numofRecord,1);
    TestingAccuracy = zeros(numofRecord,1);
    Sensitivity = zeros(numofRecord,1);
    Specificity = zeros(numofRecord,1);
    Remarks = strings([numofRecord 1]);
    %Let the record start from entry 1
    count = 1;
    for k = 1 : length(featureRecutionMethod)
        % The lowest Dimension
        dim = 2;
        currentR = featureRecutionMethod{1,k};
        fprintf("---------------------------------------\n");
        fprintf("====Current Feature Reduction Method %s\n", currentR);
        while dim < maxdim
            fprintf("========Current Dimension %d, Max Dimension %d\n", dim, maxdim);
            [trn, tst] = QueryTrnTstDataAfterFR(type, scenario, currentR, dim);
            %If the current Scenario is A, I run ten times
            if strcmp(scenario, 'A')
                runTimes = 10;
                for i2 = 1: runTimes       
                    fprintf("========Run %d\n", i2);
                    %Choose Classifier according to currentC
                    [model, err] = chooseClassifier(trn, tst, currentC);
                
                    RowCount(count) = count;
                    RunCount(count) = i2;
                    ClassificationModel(count) = currentC;
                    ReductionModel(count) = currentR;
                    Dimension(count) = dim;
                    TestingAccuracy(count) = err.testingAccuracy;
                    TrainingAccuracy(count) = err.trainingAccuracy;
                    Sensitivity(count) = err.sensitivity;
                    Specificity(count) = err.specificity;
                    Remarks(count) = err.remark;
                    count = count + 1;
                    
                    if strcmp(currentC, 'KNN') || strcmp(currentC, 'SVM')
                        break;
                    end
                end
            else
                [model, err] = chooseClassifier(trn, tst, currentC);
                
                RowCount(count) = count;
                RunCount(count) = 1;
                ClassificationModel(count) = currentC;
                ReductionModel(count) = currentR;
                Dimension(count) = dim;
                TestingAccuracy(count) = err.testingAccuracy;
                TrainingAccuracy(count) = err.trainingAccuracy;
                Sensitivity(count) = err.sensitivity;
                Specificity(count) = err.specificity;
                Remarks(count) = err.remark;
                count = count + 1;
            end
            %Only store the final Model
            info = GETPNAMEForClassifiersModel(type, scenario, currentC, currentR, dim,10);        
            modelName = info.modelName;
            modelFilename = info.modelFilename;
            S.(modelName) = model;
            save(modelFilename, '-struct', 'S');
            clear S;
            dim = dim + 2;
        end
    end
    
    RecordTable.(recordName) = table(RowCount,RunCount, ClassificationModel, ReductionModel, Dimension, TrainingAccuracy, TestingAccuracy, Sensitivity, Specificity, Remarks);        
    save(recordFilename, '-struct', 'RecordTable');
    clear RecordTable;
end

function [model, err] = chooseClassifier(trn, tst, currentC)
    switch currentC
        case 'FisherLDA'
           [model, err] = TrainAndTestFisherLDA(trn, tst);  
        case 'MDC'
           [model, err] = TrainandTestMDC(trn,tst);  
        case 'KNN'
            [model, err] = TrainandTestKNN(trn, tst);
        case 'Bayes'
            [model, err] = TrainandTestBayes(trn, tst);
        case 'SVM'
            [model, err] = TrainandTestSVM(trn, tst);
    end
end