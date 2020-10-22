function [model,err] = TrainandTestMDC(trn,tst)
    if max(unique(trn.y)) == 2
        trn = classBalancing(trn);
    end
    class_means = TrainMLD(trn);
    ypred1 = UseMLD(tst, class_means);
    ypred2 = UseMLD(trn, class_means);
    err.testingAccuracy = 1 - cerror(ypred1, tst.y); %evaluate the testing error
    err.trainingAccuracy = 1 - cerror(ypred2, trn.y); %evaluate the testing error
    err.testingAccuracy = round(err.testingAccuracy*100,2);
    err.trainingAccuracy = round(err.trainingAccuracy*100,2);
    [err.sensitivity, err.specificity] = CalculateSensitivityAndSpecificity(ypred1,tst.y);
    %plot_dec_boundaries(trn.X', trn.y, class_means');
    %plot_dec_boundaries(tst.X', tst.y, class_means');
    err.remark = "None";
    
    %
    model.class_means = class_means;
    model.ypred = ypred1;
    model.y = tst.y;
end

function class_means = TrainMLD(trn)
    % total number of classes {1 ... n}
    n_classes = max(unique(trn.y));

    % size of the feature space
    d_features = trn.dim;

    % preallocate sample mean array
    class_means = zeros(d_features, n_classes);

    % calculate mean for each class
    for i = 1:n_classes
        class_means(:,i) = mean(trn.X(:, trn.y == i), 2);
    end
end

function ypred = UseMLD(data, class_means)
    % compute the total number of samples in the data set
    n_samples = data.num_data;

    % compute the euclidean distances between every data sample and each of the 
    % class means
    x = data.X';
    distances = pdist2(real(x), real(class_means'), 'euclidean');

    % preallocate the prediction array
    ypred = zeros(1, n_samples);
    % for each distance vector, increment error count if an incorrect
    % classification occurs
    for i = 1:n_samples
        idx = find(distances(i, :) == min(distances(i, :)));
        ypred(i) = idx;
    end
end