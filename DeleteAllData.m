%Clear all of the stored information
%--------------------------------------------------------------------------
%Dekete project data
%--------------------------------------------------------------------------
mainPath = [pwd '/'];
userpath (mainPath);
addpath([mainPath 'Paths'])
deleteData(mainPath);
deleteEDAData(mainPath);
deleteFeatureSelectionData(mainPath);
deleteFeatureReductionData(mainPath);
deleteClassifierData(mainPath);
%--------------------------------------------------------------------------
% Delete Data on the data Path
%--------------------------------------------------------------------------
function deleteData(mainPath)
    dataFolder = 'Data';
    scenarios(1) = 'A'; %Scenario A
    scenarios(2) = 'B'; %Scenario B
    scenarios(3) = 'C'; %Scenario C
    subpathNames(1) = "FeatureReduction/PCA";
    subpathNames(2) = "FeatureReduction/LDA";
    subpathNames(3) = "FeatureReduction/LDA_PCA";
    subpathNames(4) = "FeatureSelection";
    subpathNames(5) = "OriginalData";
    subpathNames(6) = "TrainingTesting";
    subpathNames(7) = "FeatureReduction";
    
    for i = 1 : length(scenarios)
        for j = 1 : length(subpathNames)
            dataPath = strjoin([mainPath dataFolder '/' scenarios(i) '/' subpathNames(j)], '');
            if exist(dataPath, 'dir')
                rmdir(dataPath,'s')
            end
        end
    end
end
%--------------------------------------------------------------------------
% Delete for EDA
%--------------------------------------------------------------------------
function deleteEDAData(mainPath)
    EDAFolder = 'EDA';
    scenarios(1) = 'A'; %Scenario A
    scenarios(2) = 'B'; %Scenario B
    scenarios(3) = 'C'; %Scenario C
    subpathNames(1) = "DataProfiles";
    subpathNames(2) = "DescriptiveStats";
        
    for i = 1 : length(scenarios)
        for j = 1 : length(subpathNames)
            edaPath = strjoin([mainPath EDAFolder '/' scenarios(i) '/' subpathNames(j)], '');
            if exist(edaPath, 'dir')
                rmdir(edaPath,'s')
            end
        end
    end
    
    topic = "/Visualization/";
    components(1) = "ap/";
    components(2) = "aw/";
    components(3) = "gp/";
    components(4) = "gw/";
    graph_type(1) = "Boxplot/";
    graph_type(2) = "Histogram/";    
    graph_type(3) = "Pattern/";    
    graph_type(4) = "Trend/";
    time_sequence(1) = "Before";
    time_sequence(2) = "After";
    
    for i = 1 : length(components)
        for j = 1 : length(graph_type)
            for k = 1 : length(time_sequence) 
                c_path = strjoin([mainPath EDAFolder topic components(i) graph_type(j) time_sequence(k)], '');
                if exist(c_path, 'dir')
                    rmdir(c_path,'s')
                end
            end
        end
    end
end
%--------------------------------------------------------------------------
% Delete Data for Feature Selection
%--------------------------------------------------------------------------
function deleteFeatureSelectionData(mainPath)
    featureSelectionFolder = 'FeatureSelection';
    scenarios(1) = 'A'; %Scenario A
    scenarios(2) = 'B'; %Scenario B
    scenarios(3) = 'C'; %Scenario C

    subpathNames(1) = "RankStats";   

    for i = 1 : length(scenarios)
        for j = 1 : length(subpathNames)
            fSPath = strjoin([mainPath featureSelectionFolder '/' scenarios(i) '/' subpathNames(j)], '');
            if exist(fSPath, 'dir')
                rmdir(fSPath,'s')
            end
        end
    end
end
%--------------------------------------------------------------------------
% Delete Data for Feature Reduction
%--------------------------------------------------------------------------
function deleteFeatureReductionData(mainPath)
    featureReductionFolder = 'FeatureReduction';
    scenarios(1) = 'A'; %Scenario A
    scenarios(2) = 'B'; %Scenario B
    scenarios(3) = 'C'; %Scenario C

    subpathNames(1) = "Visualization";   
    subpathNames(2) = "LDAModel";   
    subpathNames(3) = "PCAModel";
    subpathNames(4) = "LDA_PCAModel";
    
    for i = 1 : length(scenarios)
        for j = 1 : length(subpathNames)
            fSPath = strjoin([mainPath featureReductionFolder '/' scenarios(i) '/' subpathNames(j)], '');
            if exist(fSPath, 'dir')
                rmdir(fSPath,'s')
            end
        end
    end
end
%--------------------------------------------------------------------------
% Delete Classifiers Data
%--------------------------------------------------------------------------
function deleteClassifierData(mainPath)
    classifierFolder = 'Classifier';
    
    scenarios(1) = 'A'; %Scenario A
    scenarios(2) = 'B'; %Scenario B
    scenarios(3) = 'C'; %Scenario C
    
    modeltype(1) = "Bayes";
    modeltype(2) = "FisherLDA";
    modeltype(3) = "KNN";
    modeltype(4) = "MDC";
    modeltype(5) = "SVM";
    
    subpathNames(1) = "Model";   
    subpathNames(2) = "Record";   

    for s = 1 : length(scenarios)
        tempPath =  [mainPath classifierFolder '/' scenarios(s) '/'];
        for i = 1 : length(modeltype)
            tempPath2 = strjoin([tempPath modeltype(i) '/'], '');
            for j = 1 : length(subpathNames)
                cPath = strjoin([tempPath2 subpathNames(j)], '');
                if exist(cPath, 'dir')
                    rmdir(cPath,'s')
                end
            end
        end
    end
end