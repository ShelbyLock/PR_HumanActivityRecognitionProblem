function [model, err] = TrainandTestSVM(trn, tst)
    trn.X = real(trn.X);
    tst.X = real(tst.X);
    if length(unique(trn.y')) > 2
        %Multi-Class Classification
        fprintf("Multi-Class Classification\n");
        [model, err] = MultiClassSVM(trn, tst);
    else
        %Two Class Classification
        fprintf("Two Class Classification\n");
        [model, err] = BinarySVM(trn, tst);
    end
end

function [model, err] = BinarySVM(trn, tst)
    c_pot = -5:3;
    Cost = power(2, c_pot);
    n_runs = 2;
    totalRuns_times_numCost = n_runs * numel(Cost) * 2;
    Models = cell(1, totalRuns_times_numCost);
    Accuracies = zeros(1, totalRuns_times_numCost);
    Specificities = zeros(1, totalRuns_times_numCost);
    Sensitivities = zeros(1, totalRuns_times_numCost);
    CostsRecord = zeros(1, totalRuns_times_numCost);
    Remarks_Temp = strings([1 totalRuns_times_numCost]);
    count = 0; %count = ((current_n - 1) * total_c) + current_C;
    for n = 1:n_runs
        fprintf("==== Run %d\n", n);
        %Seperate A portion of data into validation set
        %Random sampling 
        all_idx = 1:(trn.num_data/10);
        validation_num = ceil(0.2 * length(all_idx));
        val_idx = randsample(trn.num_data/10,validation_num); %
        trn_idx = setdiff(all_idx,val_idx');
        val = trn;
        val.X = val.X(:, val_idx);
        val.y = val.y(val_idx);
        val.num_data = validation_num;
        trn.X = trn.X(:, trn_idx);
        trn.y = trn.y(trn_idx);   
        trn.num_data = trn.num_data - validation_num;
        for c = 1 : numel(Cost)
            fprintf("Current Cost %.2f\n", Cost(c));
            
            fprintf("RBF Kernel function. \n");
            count = count + 1;
            Models{count} = fitcsvm(trn.X',trn.y','Standardize',true,'KernelFunction','RBF',...
                'KernelScale','auto', 'BoxConstraint',Cost(c),'Solver','SMO');
            ypred_validation = predict(Models{count}, val.X');
            Accuracies(count) = 1 - cerror(ypred_validation, val.y);
            Accuracies(count) = round(Accuracies(count) * 100,2);
            [Sensitivities(count), Specificities(count)] = CalculateSensitivityAndSpecificity(ypred_validation,val.y);
            fprintf("Validation Accu %.2f Spec %.2f Sens %.2f \n", Accuracies(count), Specificities(count), Sensitivities(count));
            CostsRecord(count) = Cost(c);
            Remarks_Temp(count) = "RBF Kernel";
            
            fprintf("Linear Kernel function. \n");
            count = count + 1;
            Models{count} = fitcsvm(trn.X',trn.y','Standardize',true,'KernelFunction','linear',...
                'KernelScale','auto', 'BoxConstraint',Cost(c),'Solver','SMO');
            ypred_validation = predict(Models{count}, val.X');
            Accuracies(count) = 1 - cerror(ypred_validation, val.y);
            Accuracies(count) = round(Accuracies(count) * 100,2);
            [Sensitivities(count), Specificities(count)] = CalculateSensitivityAndSpecificity(ypred_validation,val.y);
            fprintf("Validation Accu %.2f Spec %.2f Sens %.2f \n", Accuracies(count), Specificities(count), Sensitivities(count));
            CostsRecord(count) = Cost(c);
            Remarks_Temp(count) = "Linear Kernel";
        end
       
    end    
    %Select the best classification model in terms of validation performance
    [~,I_sortedAccu] = sort(Accuracies,'descend');
    [~,I_sortedSpec] = sort(Specificities,'descend');
    [~,I_sortedSens] = sort(Sensitivities,'descend');
    
    % Define Weigted Ratio
    importanceofAccuracies = 0.3;
    importanceofSpecificities = 0.4;
    importanceofSensitivities = 0.3;
    
    fullScore = 100;
    
    ModelRankTemp = zeros(1,totalRuns_times_numCost);
    
    for i = 1 : totalRuns_times_numCost
       accuScore = (fullScore - find(I_sortedAccu == i) + 1) * importanceofAccuracies;
       specScore = (fullScore - find(I_sortedSpec == i) + 1) * importanceofSpecificities; 
       sensScore = (fullScore - find(I_sortedSens == i) + 1) * importanceofSensitivities; 
       ModelRankTemp(i) =  accuScore + specScore + sensScore;
    end
    
    [~,BestI] = max(ModelRankTemp);
    fprintf("Best I = %d, Validation Accu %.2f Spec %.2f Sens %.2f \n", BestI, Accuracies(BestI), Specificities(BestI), Sensitivities(BestI));
    model = Models{BestI};
    ypred1 = predict(model,tst.X');
    err.testingAccuracy = 1 - cerror(ypred1, tst.y);
    err.testingAccuracy = round(err.testingAccuracy*100,2);
    ypred2 = predict(model,trn.X');
    err.trainingAccuracy = 1 - cerror(ypred2, trn.y);
    err.trainingAccuracy = round(err.trainingAccuracy*100,2);
    %
    model.y = tst.y;
    model.ypred = ypred1;
    [err.sensitivity, err.specificity] = CalculateSensitivityAndSpecificity(ypred1,tst.y);
    
    fprintf("Best I = %d, Testing Accu %.2f Spec %.2f Sens %.2f \n", BestI, err.testingAccuracy , err.sensitivity, err.specificity);
    err.remark = strjoin(['Cost =' num2str(CostsRecord(BestI)) 'Remark: ' Remarks_Temp(BestI)]);
end
function [model, err] = MultiClassSVM(trn, tst)
    c_pot = -5:1;
    g_pot = -5:1;
    C=power(2,c_pot); %Cost
    G=power(2,g_pot); %Gamma
    n_runs = 1;
    totalRuns_times_numCost_time_numGamma = n_runs * numel(C) * numel(G) * 2;
    Models = cell(1, totalRuns_times_numCost_time_numGamma);
    Accuracies = zeros(1, totalRuns_times_numCost_time_numGamma);
    Specificities = zeros(1, totalRuns_times_numCost_time_numGamma);
    Sensitivities = zeros(1, totalRuns_times_numCost_time_numGamma);
    CostsRecord = zeros(1, totalRuns_times_numCost_time_numGamma);
    GammaRecord = zeros(1, totalRuns_times_numCost_time_numGamma);
    Remarks_Temp = strings([1 totalRuns_times_numCost_time_numGamma]);
    count = 0; 
    for n = 1:n_runs
        fprintf("==== Run %d", n);
        %Seperate A portion of data into validation set
        %Random sampling 
        all_idx = 1:(trn.num_data/10);
        validation_num = ceil(0.2 * length(all_idx));
        val_idx = randsample(trn.num_data/10,validation_num); %
        trn_idx = setdiff(all_idx,val_idx');
        val = trn;
        val.X = val.X(:, val_idx);
        val.y = val.y(val_idx);
        val.num_data = validation_num;
        trn.X = trn.X(:, trn_idx);
        trn.y = trn.y(trn_idx);   
        trn.num_data = trn.num_data - validation_num;
        %Run one vs one
        for c = 1 : numel(C)
            fprintf("Current Cost %.2f\n", C(c));
            for g=1:numel(G) %Test different values of the kernel parameter
                fprintf("====One Vs One====\n");
                count = count + 1;
                t = templateSVM('KernelFunction','rbf',...
                    'BoxConstraint',C(c),...
                    'KernelScale',sqrt(1/(2*G(g))),'Solver','SMO');
        
                Models{count} = fitcecoc(trn.X',trn.y','Coding','onevsone','Learners',t);
                ypred_validation = predict(Models{count},val.X');
                Accuracies(count) = 1 - cerror(ypred_validation, val.y);
                Accuracies(count) = round(Accuracies(count) * 100,2);
                [Sensitivities(count), Specificities(count)] = CalculateSensitivityAndSpecificity(ypred_validation,val.y);
                fprintf("Validation Accu %.2f Spec %.2f Sens %.2f \n", Accuracies(count), Specificities(count), Sensitivities(count));
                CostsRecord(count) = C(c);
                GammaRecord(count) = G(g);
                Remarks_Temp(count) = "onevsone";
            end % Gamma parameter --> RBF kernel
        end
        %Run one vs all
        for c = 1 : numel(C)
            for g=1:numel(G) %Test different values of the kernel parameter
                fprintf("====One Vs All====\n");
                count = count + 1;
                t = templateSVM('KernelFunction','rbf',...
                    'BoxConstraint',C(c),...
                    'KernelScale',sqrt(1/(2*G(g))),'Solver','SMO');
        
                Models{count} = fitcecoc(trn.X',trn.y','Coding','onevsall','Learners',t);
                ypred_validation = predict(Models{count},val.X');
                Accuracies(count) = 1 - cerror(ypred_validation, val.y);
                Accuracies(count) = round(Accuracies(count) * 100,2);
                [Sensitivities(count), Specificities(count)] = CalculateSensitivityAndSpecificity(ypred_validation,val.y);
                fprintf("Validation Accu %.2f Spec %.2f Sens %.2f \n", Accuracies(count), Specificities(count), Sensitivities(count));
                CostsRecord(count) = C(c);
                GammaRecord(count) = G(g);
                Remarks_Temp(count) = "onevsall";
            end % Gamma parameter --> RBF kernel
        end
    end    
    %Select the best classification model in terms of validation performance
    [~,I_sortedAccu] = sort(Accuracies,'descend');
    [~,I_sortedSpec] = sort(Specificities,'descend');
    [~,I_sortedSens] = sort(Sensitivities,'descend');
    
    % Define Weigted Ratio
    importanceofAccuracies = 0.3;
    importanceofSpecificities = 0.4;
    importanceofSensitivities = 0.3;
    
    fullScore = 100;
    
    ModelRankTemp = zeros(1,totalRuns_times_numCost_time_numGamma);
    
    for i = 1 : totalRuns_times_numCost_time_numGamma
       accuScore = (fullScore - find(I_sortedAccu == i) + 1) * importanceofAccuracies;
       specScore = (fullScore - find(I_sortedSpec == i) + 1) * importanceofSpecificities; 
       sensScore = (fullScore - find(I_sortedSens == i) + 1) * importanceofSensitivities; 
       ModelRankTemp(i) =  accuScore + specScore + sensScore;
    end
    
    [~,BestI] = max(ModelRankTemp);
    fprintf("Best I = %d, Validation Accu %.2f Spec %.2f Sens %.2f \n", BestI, Accuracies(BestI), Specificities(BestI), Sensitivities(BestI));
    model = Models{BestI};
    ypred1 = predict(model,tst.X');
    err.testingAccuracy = 1 - cerror(ypred1, tst.y);
    err.testingAccuracy = round(err.testingAccuracy*100,2);
    ypred2 = predict(model,trn.X');
    err.trainingAccuracy = 1 - cerror(ypred2, trn.y);
    err.trainingAccuracy = round(err.trainingAccuracy*100,2);
    
    %
    model.y = tst.y;
    model.ypred = ypred1;
    
    [err.sensitivity, err.specificity] = CalculateSensitivityAndSpecificity(ypred1,tst.y);
    
    fprintf("Best I = %d, Testing Accu %.2f Spec %.2f Sens %.2f \n", BestI, err.testingAccuracy , err.sensitivity, err.specificity);
    err.remark = strjoin(['Cost = ' num2str(CostsRecord(BestI)) ', Gamma = ' num2str(GammaRecord(BestI)) ', Remark: ' Remarks_Temp(BestI)]);
end