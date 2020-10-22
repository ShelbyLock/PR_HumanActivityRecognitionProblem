function [model, err] = TrainandTestBayes(trn, tst)
    n_classes = length(unique(trn.y));
    n_samples = trn.num_data;
    model.Pclass = cell(1,n_classes);
    model.Prior = zeros(1,n_classes);
    
    for i = 1 : n_classes
        currentIdx = (trn.y == i);
        current_num_data = length(find(currentIdx));
        temp_trn = trn;
        temp_trn.X = temp_trn.X(:,currentIdx);
        temp_trn.y = temp_trn.y(currentIdx);
        temp_trn.num_data = current_num_data;
        
        model.Pclass{i} = mlcgmm(temp_trn);
        model.Prior(i) = current_num_data/n_samples;
    end

    ypred1 = bayescls(tst.X,model);
    err.testingAccuracy = 1 - cerror(ypred1, tst.y);
    err.testingAccuracy = round(err.testingAccuracy*100,2);
    ypred2 = bayescls(trn.X, model);
    err.trainingAccuracy = 1 - cerror(ypred2, trn.y);
    err.trainingAccuracy = round(err.trainingAccuracy*100,2);
    
    [err.sensitivity, err.specificity] = CalculateSensitivityAndSpecificity(ypred1,tst.y);
    err.remark = "None";
    %
    model.ypred = ypred1;
    model.y = tst.y;
 end