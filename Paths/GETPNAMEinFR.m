function info = GETPNAMEinFR(type, scenario, reductionModel, dim)

     dataPath = ['./Data/' scenario '/FeatureReduction/' reductionModel '/'];
     modelPath = ['./FeatureReduction/' scenario '/' reductionModel 'Model/'];
     vPath = ['./FeatureReduction/' scenario '/Visualization/'];
     
     %Paths and names for storing Trn and Tst data after feature reduction
     trnPath = [dataPath type scenario 'trn' num2str(dim) '.mat'];
     tstPath = [dataPath type scenario 'tst' num2str(dim) '.mat'];
     trnColnamesName = [type scenario '_tcolnames' num2str(dim)];
     tstColnamesName = [type scenario '_scolnames' num2str(dim)];
       
     trnName = [type scenario '_trn' num2str(dim)];
     tstName = [type scenario '_tst' num2str(dim)];
    
     trnSetName = [type ' Trn Data After Feature Reduction Scenario' scenario num2str(dim)];
     tstSetName = [type ' Tst Data After Feature Reduction Scenario' scenario num2str(dim)];
     
     %Names for storing model
     modelFilename = [modelPath type scenario reductionModel num2str(dim) '.mat'];
     modelName = [type scenario reductionModel num2str(dim)];
     
     %Names for storing .fig files
     vFilenameEigval = [vPath 'Eigval/' type scenario reductionModel 'Eigval' num2str(dim) '.fig'];
     vFilenameEigvalSumVariance = [vPath 'Eigval/' type scenario reductionModel 'EigvalSumVariance' num2str(dim) '.fig'];
     vFilenamePCALDACompare = [vPath 'PCALDACompare/' type scenario 'PCALDACompare' num2str(dim)];
     
     vTitleEigval = [reductionModel ' Eigval Dimension in ' type ' Scenario ' scenario ' num of features: ' num2str(dim)];
     vTitleEigvalSumVariance = [ reductionModel ' Eigval Sum Variance Dimension in ' type ' Scenario ' scenario ' num of features: ' num2str(dim)];
     vTitlePCACompare = ['PCA Data in ' type ' Scenario ' scenario ' num of features: ' num2str(dim)];
     vTitleLDACompare = ['LDA Data in ' type ' Scenario ' scenario ' num of features: ' num2str(dim)];
     
     %data
     info.trnPath = trnPath;
     info.tstPath = tstPath;
     info.trnColnamesName = trnColnamesName;
     info.tstColnamesName = tstColnamesName;
     info.trnName = trnName;
     info.tstName = tstName;
     info.trnSetName = trnSetName;
     info.tstSetName = tstSetName;
     
     %model
     info.modelFilename = modelFilename;
     info.modelName = modelName;
     %visualization
     info.vFilenameEigval = vFilenameEigval;
     info.vFilenameEigvalSumVariance = vFilenameEigvalSumVariance;
     info.vFilenamePCALDACompare = vFilenamePCALDACompare;
     
     info.vTitleEigval = vTitleEigval;
     info.vTitleEigvalSumVariance = vTitleEigvalSumVariance;
     info.vTitlePCACompare = vTitlePCACompare;
     info.vTitleLDACompare = vTitleLDACompare;
end