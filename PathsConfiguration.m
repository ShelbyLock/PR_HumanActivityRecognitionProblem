clear all;
%--------------------------------------------------------------------------
%Pls write your path in here
%--------------------------------------------------------------------------
mainPath = [pwd '/'];
userpath (mainPath);
addpath([mainPath 'Paths'])
%--------------------------------------------------------------------------
%Configure stprtool path <Change it into your MATLAB Path>
%--------------------------------------------------------------------------
addpath '/Applications/MATLAB_R2020b.app/toolbox/stprtool'
stprpath('/Applications/MATLAB_R2020b.app/toolbox/stprtool/')
%--------------------------------------------------------------------------
%Configure project paths
%--------------------------------------------------------------------------
addDataPath(mainPath);
addEDAPath(mainPath);
addFeatureSelectionPath(mainPath);
addFeatureReductionPath(mainPath);
addClassifierAPath(mainPath);
%--------------------------------------------------------------------------
% Configure Paths for Data
%--------------------------------------------------------------------------
function addDataPath(mainPath)
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
    
    addpath(dataFolder);
    for i = 1 : length(scenarios)
        for j = 1 : length(subpathNames)
            dataPath = strjoin([mainPath dataFolder '/' scenarios(i) '/' subpathNames(j)], '');
            if ~exist(dataPath, 'dir')
                mkdir(dataPath)
            end
            addpath(dataPath);
        end
    end
end
%--------------------------------------------------------------------------
% Configure Paths for EDA
%--------------------------------------------------------------------------
function addEDAPath(mainPath)
    EDAFolder = 'EDA';
    scenarios(1) = 'A'; %Scenario A
    scenarios(2) = 'B'; %Scenario B
    scenarios(3) = 'C'; %Scenario C
    subpathNames(1) = "DataProfiles";
    subpathNames(2) = "DescriptiveStats";
        
    addpath(EDAFolder);

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
                if ~exist(c_path, 'dir')
                    mkdir(c_path)
                end
                addpath(c_path);
            end
        end
    end
    
    for i = 1 : length(scenarios)
        for j = 1 : length(subpathNames)
            edaPath = strjoin([mainPath EDAFolder '/' scenarios(i) '/' subpathNames(j)], '');
            if ~exist(edaPath, 'dir')
                mkdir(edaPath)
            end
            addpath(edaPath);
        end
    end
end
%--------------------------------------------------------------------------
% Configure Paths for Feature Selection
%--------------------------------------------------------------------------
function addFeatureSelectionPath(mainPath)
    featureSelectionFolder = 'FeatureSelection';
    scenarios(1) = 'A'; %Scenario A
    scenarios(2) = 'B'; %Scenario B
    scenarios(3) = 'C'; %Scenario C

    subpathNames(1) = "RankStats";   

    addpath(featureSelectionFolder);
    for i = 1 : length(scenarios)
        for j = 1 : length(subpathNames)
            fSPath = strjoin([mainPath featureSelectionFolder '/' scenarios(i) '/' subpathNames(j)], '');
            if ~exist(fSPath, 'dir')
                mkdir(fSPath)
            end
            addpath(fSPath);
        end
    end
end
%--------------------------------------------------------------------------
% Configure Paths for Feature Reduction
%--------------------------------------------------------------------------
function addFeatureReductionPath(mainPath)
    featureReductionFolder = 'FeatureReduction';
    scenarios(1) = 'A'; %Scenario A
    scenarios(2) = 'B'; %Scenario B
    scenarios(3) = 'C'; %Scenario C

    subpathNames(1) = "Visualization/Eigval";   
    subpathNames(2) = "Visualization/PCALDACompare";       
    subpathNames(3) = "LDAModel";   
    subpathNames(4) = "PCAModel";
    subpathNames(5) = "LDA_PCAModel";
    
    addpath(featureReductionFolder);
    for i = 1 : length(scenarios)
        for j = 1 : length(subpathNames)
            fSPath = strjoin([mainPath featureReductionFolder '/' scenarios(i) '/' subpathNames(j)], '');
            if ~exist(fSPath, 'dir')
                mkdir(fSPath)
            end
            addpath(fSPath);
        end
    end
end

%--------------------------------------------------------------------------
% Configure Paths for Classifier A
%--------------------------------------------------------------------------
function addClassifierAPath(mainPath)
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

    addpath(classifierFolder);
    for s = 1 : length(scenarios)
        tempPath =  [mainPath classifierFolder '/' scenarios(s) '/'];
        addpath(tempPath);
        for i = 1 : length(modeltype)
            tempPath2 = strjoin([tempPath modeltype(i) '/'], '');
            addpath(tempPath2);
            for j = 1 : length(subpathNames)
                cPath = strjoin([tempPath2 subpathNames(j)], '');
                if ~exist(cPath, 'dir')
                    mkdir(cPath)
                end
                addpath(cPath);
            end
        end
    end
end