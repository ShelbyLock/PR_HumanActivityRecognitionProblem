function findBestClassifiers()
    types{1,1} = 'ap';
    types{1,2} = 'aw';
    types{1,3} = 'gp';
    types{1,4} = 'gw';
    
    scenarios(1) = 'A'; %Scenario A
    scenarios(2) = 'B'; %Scenario B
    scenarios(3) = 'C'; %Scenario C
    
    classificationMethod{1,1} = 'FisherLDA';
    classificationMethod{1,2} = 'MDC';
    classificationMethod{1,3} = 'Bayes';
    classificationMethod{1,4} = 'KNN';
    classificationMethod{1,5} = 'SVM';
    fprintf('================= \n');
    fprintf('Best Classifier in ');
    for i1 = 1 : length(types)
        type = types{i1};
        fprintf(' %s', type);
        for i2 = 2 : length(scenarios) 
            scenario = scenarios(i2); 
            fprintf(' %s\n', scenario);
            tempT = table;
            count = 0;
            for i3 = 1:length(classificationMethod)
                count  = count + 1;
                cMethod = classificationMethod{i3};
                fprintf(' using %s\n', cMethod);
                info = GETPNAMEForClassifiersRecord(type, scenario, cMethod);
                T = importdata(info.recordFilename);
                Accuracies = T.TestingAccuracy;
                Sensitivities = T.Sensitivity;
                Specificities = T.Specificity;
                
                %Select the best classification model in terms of validation performance
                [~,I_sortedAccu] = sort(Accuracies,'descend');
                [~,I_sortedSpec] = sort(Specificities,'descend');
                [~,I_sortedSens] = sort(Sensitivities,'descend');
    
                % Define Weigted Ratio
                importanceofAccuracies = 0.3;
                importanceofSpecificities = 0.4;
                importanceofSensitivities = 0.3;
    
                fullScore = 100;
    
                ModelRankTemp = zeros(1,length(Specificities));
    
                for i = 1 : length(Specificities)
                    accuScore = (fullScore - find(I_sortedAccu == i) + 1) * importanceofAccuracies;
                    specScore = (fullScore - find(I_sortedSpec == i) + 1) * importanceofSpecificities; 
                    sensScore = (fullScore - find(I_sortedSens == i) + 1) * importanceofSensitivities; 
                    ModelRankTemp(i) =  accuScore + specScore + sensScore;
                end
    
                [~,BestI] = max(ModelRankTemp);
                disp(T(BestI,:))
                fprintf('\n');
                
                tempT = [tempT; T(BestI,3:9)];
                % I add this on 28 May, It dose not apear in the final
                % submission
                %[trn, tst] = QueryTrnTstDataAfterFR(type, scenario, T.ReductionModel(BestI), T.Dimension(BestI));
                %[model, err] = chooseClassifier(trn, tst, cMethod);
                %tit = strjoin([type ' ' scenario ' '  T.ReductionModel(BestI) ' ' cMethod ' ' T.Dimension(BestI)]);
                %PlotConfusionMatrix(model.ypred(1:100), model.y(1:100),tit);
            end
            path = ['./' type scenario num2str(count) '.xlsx'];
            writetable(tempT, path,'Sheet', 1);
        end
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
    
end