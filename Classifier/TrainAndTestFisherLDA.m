function [model, err] = TrainAndTestFisherLDA(trn, tst)

    if length(unique(trn.y')) > 2
        %Multi-Class Classification
        model = fld_multiclass(trn); %Train Classifier
        ypred1 = linclass_multiclass(tst.X,model);
        ypred2 = linclass_multiclass(trn.X,model);
        %fprintf("correct Classification is %d",ypred);
    else
        %Two Class Classification
        trn = classBalancing(trn);
        model = fld(trn);                          %train fld Classifier
        ypred1 = linclass(tst.X, model);           %classify Testing data
        ypred2 = linclass(trn.X, model);           %classify Testing data
    end
    
    err.testingAccuracy = 1 - cerror(ypred1, tst.y); %evaluate the testing error
    err.trainingAccuracy = 1 - cerror(ypred2, trn.y); %evaluate the testing error
    
    err.testingAccuracy = round(err.testingAccuracy*100,2);
    err.trainingAccuracy = round(err.trainingAccuracy*100,2);
    
    [err.sensitivity, err.specificity] = CalculateSensitivityAndSpecificity(ypred1,tst.y);
    
    err.remark = "None";
    %figure;
    %ppatterns(trn); pline(model);     %plot data and solution
    %saveas(gcf,plot_path1);
    %saveas(gcf,plot_path2);
    %
    model.ypred = ypred1;
    model.y = tst.y;
end

function model = fld_multiclass(trn)
    %----------------------------------------------------------------------
    % inputs
    %----------------------------------------------------------------------
    d_feature = trn.dim;
    n_samples = trn.num_data;
   
    %----------------------------------------------------------------------    
    % compute means and scatter matrix
    %----------------------------------------------------------------------
    % Compute local Mu, cov matrix, and number of observation of
    % for each class class   
    i=1;
    n_classes_temp = unique(trn.y');
    n_classes = length(n_classes_temp);
    Mus = cell(1,n_classes);
    CovVals = cell(1,n_classes);
    Ns = zeros(1,n_classes);
    Priors = zeros(1,n_classes);
    for current_class_label = 1 : n_classes
        currentX=trn.X(:,trn.y==current_class_label);
        currentMu = mean(currentX,2);
        currentSigma = cov(currentX');
        Mus(i) = {currentMu};
        CovVals(i) = {currentSigma};
        Ns(i)=size(currentX,2);
        Priors(i) = Ns(i)/n_samples;
        i=i+1;
    end
     
    %Computing  the Global Mu which is the overall mean of all data,X
    Global_Mu = mean(trn.X,2);
    SB = zeros(d_feature,d_feature);
    SW = zeros(d_feature,d_feature);
    
    for i = 1:n_classes
        SB = SB + Ns(i).*(Mus{i}-Global_Mu)*(Mus{i}-Global_Mu)';
        SW = SW+CovVals{i};
    end
    %----------------------------------------------------------------------    
    % compute W and B
    %----------------------------------------------------------------------    
    invSw = inv(SW);
    invSw_by_SB = invSw * SB;
    [V,D] = eig(invSw_by_SB);
    eigval=diag(D);
    % Sort invSw_by_SB (which is a matrix of eigen vectors) and then select 
    % the top vectors assocaited with the top eigen values as follows  
    % Sorting
    [~,sort_eigval_index]=sort(eigval,'descend');
    % Selecting the top vectors
    %W=V(:,sort_eigval_index);
    W = V;
    B = zeros(d_feature,1);
    for i = 1:  n_classes
        Projected_Mus = W' * Mus{i};
        B = B + Projected_Mus;
    end
    B = -B/n_classes;
    
    model.W = W;
    model.B = B;
    model.Mus = Mus;
    model.CovVals = CovVals;
    model.Priors = Priors;
end
function ypred = linclass_multiclass(data,model)
    n_features = size(data,1);
    n_samples = size(data,2);
    W = model.W;
    B = model.B;
    Mus = model.Mus;
    CovVals = model.CovVals;
    Priors = model.Priors;
    Z = W' * data + B;
    %Z = W' * data;
    n_classes = length(Priors);
    res = zeros(n_samples,n_classes);
    for i = 1: n_classes
        mu = Mus{i};
        colVal = CovVals{i};
        prior = Priors(i);
        [~,err] = cholcov(colVal,0);
        if err ~= 0
            %Avoid the error: "SIGMA must be a square, symmetric, positive definite matrix."
            %This happens if the diagonal values of the covariance matrix are (very close to) zero. 
            %A simple fix is add a very small constant number to c.
            colVal = colVal+ .0001 * eye(n_features); 
            fprintf("Sigma close to zero, apply a simple fix!\n");
        end
        density = mvnpdf(Z',mu',colVal);
        res(:,i) = density * prior;
    end
    
    ypred = zeros(1,n_samples);
    for j = 1: n_samples
        [~, ypred(j)] = max(res(j,1:n_classes));
    end
end