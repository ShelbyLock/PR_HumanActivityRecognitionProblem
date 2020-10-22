function FeatureReduction()
    types{1,1} = 'ap';
    types{1,2} = 'aw';
    types{1,3} = 'gp';
    types{1,4} = 'gw';
    
    scenarios{1,1} = 'A';
    scenarios{1,2} = 'B';
    scenarios{1,3} = 'C';

    for i = 1 : 4
       type = types{1,i};
       for j = 1 : 3
           scenario = scenarios{1,j};
           close all;
           [trn, ~, tst, ~] = QueryTrnTstDataAfterFS(type, scenario);
           maxdim = trn.dim;
           dim = 2;
           while dim < maxdim
                performFeatureReduction(trn, tst,type, scenario, dim);
                dim = dim + 2;
           end
        %Add this line on May 28.
        close all;
       end
   end
        
end

function performFeatureReduction(trn, tst, type, scenario, dim)
    featureRecutionMethod{1,1} = 'PCA';
    featureRecutionMethod{1,2} = 'LDA';
    featureRecutionMethod{1,3} = 'LDA_PCA';    
        
    for i = 1: length(featureRecutionMethod)
        currentMethod = featureRecutionMethod{1,i};  
        %------------------------------------------------------------------
        %Get paths and names info
        info = GETPNAMEinFR(type, scenario, currentMethod, dim);
        
        %------------------------------------------------------------------
        % Perform Feature Reduction
        %------------------------------------------------------------------        
        switch i
            case 1
                [trn, ~, model] = PerformPCA(trn, dim);
                PlotEigval(model,info);
                tst = UseFeatureReductionModel(tst, model, dim);
            case 2
                [trn, ~, model] = PerformLDA(trn, dim);
                tst = UseFeatureReductionModel(tst, model, dim);
            case 3
                [trn1, ~, model.lda] = PerformLDA(trn, dim);
                tst1 = UseFeatureReductionModel(tst, model.lda, dim);
                [trn, ~, model.pca] = PerformPCA(trn1, dim);  
                tst = UseFeatureReductionModel(tst1, model.pca, dim);
                PlotEigval(model.pca,info);
                ComparePCAandLDA(trn,trn1, info);
        end
        %Give name to the generated dataset
        trn.name = info.trnSetName;    
        tst.name = info.tstSetName;
        %Save Model
        S1.(info.modelName) = model;
        save(info.modelFilename, '-struct', 'S1');
        clear S1;
        clear model;
        %Put the dateset in a struct
        S2.(info.trnName) = trn;
        save(info.trnPath, '-struct', 'S2');
        clear S2;
        S3.(info.tstName) = tst;
        save(info.tstPath, '-struct', 'S3');
        clear S3;
    end
end

