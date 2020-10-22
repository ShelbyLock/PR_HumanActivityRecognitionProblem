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
       end
   end
        
end

function performFeatureReduction(trn, tst, type, scenario, dim)
    featureRecutionMethod{1,1} = 'PCA';
    featureRecutionMethod{1,1} = 'PCA';
    %------------------------------------------------------------------
    % Perform PCA
    %------------------------------------------------------------------
    [pca_trn, ~, pca_model] = PerformPCA(trn, dim);
    %------------------------------------------------------------------
    %Get paths and names info
    info = GETPNAMEinFR(type, scenario, 'PCA', dim);
    %data info
    trnPath1 = info.trnPath;
    tstPath1 = info.tstPath;
    trnName1 = info.trnName;
    tstName1 = info.tstName;
    trnSetName1 = info.trnSetName;
    tstSetName1 = info.tstSetName;
    %model info
    modelFilename1 = info.modelFilename;
    modelName1 = info.modelName;
    %------------------------------------------------------------------
    %Plot eigval
    PlotEigval(pca_model,info);
    %Give name to the generated dataset
    pca_trn.name = trnSetName1;      
    %Save Model
    S1.(modelName1) = pca_model;
    save(modelFilename1, '-struct', 'S1');
    clear S1;
    %Put the dateset in a struct
    PCATRN.(trnName1) = pca_trn;
    save(trnPath1, '-struct', 'PCATRN');
    clear PCATRN;
    %------------------------------------------------------------------
    % Perform LDA
    %------------------------------------------------------------------
    [lda_trn, ~, lda_model] = PerformLDA(trn, dim);
    %------------------------------------------------------------------
    %Get paths and names info
    info = GETPNAMEinFR(type, scenario, 'LDA', dim);
    %data info
    trnPath2 = info.trnPath;
    tstPath2 = info.tstPath;
    %trnColnamesName2 = info.trnColnamesName;
    %tstColnamesName2 = info.tstColnamesName;
    trnName2 = info.trnName;
    tstName2 = info.tstName;
    trnSetName2 = info.trnSetName;
    tstSetName2 = info.tstSetName;
    %model info
    modelFilename2 = info.modelFilename;
    modelName2 = info.modelName;
    %------------------------------------------------------------------
    %Plot compare plot
    %ComparePCAandLDA(pca_trn, lda_trn, info)
    %Give name to the generated dataset
    lda_trn.name = trnSetName2;
    %Save Model
    S1.(modelName2) = lda_model;
    save(modelFilename2, '-struct', 'S1');
    clear S1;
    %Put the dateset in a struct
    LDATRN.(trnName2) = lda_trn;
    save(trnPath2, '-struct', 'LDATRN');
    clear LDATRN;
       
    %------------------------------------------------------------------
    % Get Testing Data
    %------------------------------------------------------------------
         
    pca_tst = UseFeatureReductionModel(tst, pca_model, dim);
    lda_tst = UseFeatureReductionModel(tst, lda_model, dim);
        
    pca_tst.name = tstSetName1;
    lda_tst.name = tstSetName2;
        
    PCATST.(tstName1) = pca_tst;
    LDATST.(tstName2) = lda_tst;
    save(tstPath1, '-struct', 'PCATST');
    save(tstPath2, '-struct', 'LDATST');
    close all;
end

