function [model, err] = TrainandTestKNN(trn, tst)
    fprintf("************************************* \n");
    fprintf("Training and Testing KNN classifiers. \n");
    maxK = 5;
    Models = cell(1,maxK);
    Accuracies = zeros(1,maxK);
    Specificities = zeros(1,maxK);
    Sensitivities = zeros(1,maxK);
    
    %Seperate A portion of data into validation set
    %Random sampling 
    validation_num = ceil(0.2 * trn.num_data);
    all_idx = 1:trn.num_data;
    val_idx = randsample(trn.num_data,validation_num);
    trn_idx = setdiff(all_idx,val_idx');
    val = trn;
    val.X = val.X(:, val_idx);
    val.y = val.y(val_idx);
    val.num_data = validation_num;
    trn.X = trn.X(:, trn_idx);
    trn.y = trn.y(trn_idx);   
    trn.num_data = trn.num_data - validation_num;
    % Test the classification Result with All Ks.
    % And calculate the accuracy, specificity and sensitivity using
    % training data
    for k = 1 : maxK
        fprintf("K = %d,", k);
        Models{k}=knnrule(trn,k);
        ypred_validation = knnclass(val.X, Models{k});
        Accuracies(k) = 1 - cerror(ypred_validation, val.y);
        Accuracies(k) = round(Accuracies(k)*100,2);
        [Sensitivities(k), Specificities(k)] = CalculateSensitivityAndSpecificity(ypred_validation,val.y);
        fprintf("Validation Accu %.2f Spec %.2f Sens %.2f \n", Accuracies(k), Specificities(k), Sensitivities(k));
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
    
    ModelRankTemp = zeros(1,maxK);
    for k = 1 : maxK
       accuScore = (fullScore - find(I_sortedAccu == k) + 1) * importanceofAccuracies;
       specScore = (fullScore - find(I_sortedSpec == k) + 1) * importanceofSpecificities; 
       sensScore = (fullScore - find(I_sortedSens == k) + 1) * importanceofSensitivities; 
       ModelRankTemp(k) =  accuScore + specScore + sensScore;
    end
    
    [~,BestK] = max(ModelRankTemp);
    fprintf("Best K = %d, Validation Accu %.2f Spec %.2f Sens %.2f \n", BestK, Accuracies(BestK), Specificities(BestK), Sensitivities(BestK));
    model = Models{BestK};
    ypred1 = knnclass(tst.X, model);
    err.testingAccuracy = 1 - cerror(ypred1, tst.y);
    err.testingAccuracy = round(err.testingAccuracy*100,2);
    ypred2 = knnclass(trn.X, model);
    err.trainingAccuracy = 1 - cerror(ypred2, trn.y);
    err.trainingAccuracy = round(err.trainingAccuracy*100,2);
    
    [err.sensitivity, err.specificity] = CalculateSensitivityAndSpecificity(ypred1,tst.y);
    
    fprintf("Best K = %d, Testing Accu %.2f Spec %.2f Sens %.2f \n", BestK, err.testingAccuracy , err.sensitivity, err.specificity);
    err.remark = ['K =' num2str(BestK)];
    
    %
    model.ypred = ypred1;
    model.y = tst.y;
end