function FeatureSelection()
    types{1,1} = 'ap';
    types{1,2} = 'aw';
    types{1,3} = 'gp';
    types{1,4} = 'gw';
    
    scenarios{1,1} = 'A';
    scenarios{1,2} = 'B';
    scenarios{1,3} = 'C';
    
    for i = 1 : 4
        type = types{1,i};
        shouldPlot = 1;
        for j = 1 : 3
            scenario = scenarios{1,j};
            fprintf("==================================================\n");
            fprintf("Feature Pre-processing for type %s in scenario %s\n", type, scenario);
            fprintf("Remove erroneous features. Correct outliners. Scale\n");
            fprintf("==================================================\n");
            %Query Training and Testing Data
            [trn, colnames, tst, ~] = QueryTrnTstData(type, scenario);
            %get paths and names
            info1 = GETPNAMEinEDA(type, scenario);
            %Perform EDA and preprocessing
            [trn, tst, colnames, featureID, des, covPair] = DataExploringAndCleaning(trn, tst, colnames, info1, shouldPlot);
            shouldPlot = 0;
            fprintf("==================================================\n");
            fprintf("Feature Selection for type %s in scenario %s\n", type, scenario);
            fprintf("Remove redundant features (score & rank system)\n");
            fprintf("==================================================\n");
            %Get the ranks of features
            info2 = GETPNAMEinFS(type, scenario);
            T1 = QualityRelevanceRank(des, colnames, featureID, info2);
            [trn, tst, colnames, T2] = RedundantFeaturesRemoval(trn, tst, colnames, featureID, covPair, T1, info2);
            [trn, tst, colnames] = UltimateFeatureSelection(trn, tst, colnames, T2, info2);
            
            plotBivariatePPatterns(trn, colnames, info1.vPatternAfter)
            close all;
        end
    end
end

%Bivariable Analysis
function plotBivariatePPatterns(data, colnames, patternName)
    if data.dim > 5
        data.dim = 5;
    end
    for i = 1 : (data.dim - 1)
       for j = (i + 1) : (data.dim) 
        currentData = data;
        currentData.X = currentData.X([i j],:);
        currentData.dim = 2;
        newTitle = strjoin(['Pair' colnames(i) colnames(j)]);
        fprintf('****** Plotting current Pair %s\n',newTitle);
        newPatternName = strjoin([patternName colnames(i) '_' colnames(j) '.fig'],'');
        figure; ppatterns(currentData)
        xlabel(colnames(i))
        ylabel(colnames(j))
        title(newTitle)
        saveas(gcf,newPatternName);
        clear newPatternName;
       end
    end
end