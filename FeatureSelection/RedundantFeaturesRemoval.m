function [trn, tst, dynamicColnames, T2] = RedundantFeaturesRemoval(trn, tst, colnames, featureID, covPair, T1, info)
%--------------------------------------------------------------------------
    % Coefficients above this threshold indicates redundant feature.
    coeff_threshold = 0.85;
%--------------------------------------------------------------------------    
    %Information from the features rank table
    % Features/colnames sorted by total rank core
    featureRankStaticName = T1.Feature; 
    featureRankDynamicName = T1.Feature;

    featuresTotalRankScore = T1.TotalRankScore;
%--------------------------------------------------------------------------    
    %colnames of data sequence    
    staticColnames = colnames;
    dynamicColnames = colnames;
    %featureID of data sequence
    staticFeatureID = featureID;
    dynamicFeatureID = featureID;
%--------------------------------------------------------------------------    
    % Extrace and sort coefficient values    
    covPairValue = [covPair{3,:}];
    num = length(covPairValue);
    %The desire features should be as different as possible. 
    %(the co-eff should be low)
    [~, covPairI] = sort(covPairValue, 'descend');
 %--------------------------------------------------------------------------   
    %Initialize the record variables for deleted features
    DeletedFeature = strings([num, 1]);
    DeletedFeatureId = zeros(num,1);
    DeletedFeatureScore = zeros(num,1);
    DeletedBy = strings([num, 1]);
    DeletedById = zeros(num,1);
    DeletedByScore = zeros(num,1);
    PairCoeff = zeros(num,1);
    DeleteCount = 0;
    DeleteCounts = zeros(num,1);
%--------------------------------------------------------------------------
%-Sort the pairs and delete feature according to the rank and coefficient--
%--------------------------------------------------------------------------
    fprintf('-----------Feature Delete Record:-----------\n');
    %We have ((d*d)-d)/2 pairs, for each pair, we have the following
    %operation
    for i = 1 : num 
        %------------------------------------------------------------------    
        %Identify current's pair location in the covPair array
        currentCovPairIdx = covPairI(i);
        %------------------------------------------------------------------  
        %Extract feature name and feature id in the covPair array for the
        %current pair's two features.
        feaName1 = covPair{1, currentCovPairIdx};
        feaName2 = covPair{2, currentCovPairIdx};
        
        feaId1 = strcmp(staticColnames,feaName1);
        feaId2 = strcmp(staticColnames,feaName2);        
        currentcoeff = covPair{3, currentCovPairIdx};
        assert(currentcoeff == covPairValue(currentCovPairIdx));
        %------------------------------------------------------------------         
        %Query the feature rank score with the feature name
        feaRankScore1 = featuresTotalRankScore(strcmp(featureRankStaticName,feaName1));
        feaRankScore2 = featuresTotalRankScore(strcmp(featureRankStaticName,feaName2));      
        %------------------------------------------------------------------         
        fprintf('Current Coefficient: %.2f\n', currentcoeff);
        if (currentcoeff < coeff_threshold)
            break;
        end
        %------------------------------------------------------------------   
        deleteFeature = "Nothing";
        if feaRankScore1 >= feaRankScore2
            %--------------------------------------------------------------
            % Delete feature 2
            % Check whether or not the current feature still exists.
            logi = strcmp(dynamicColnames,feaName2); 
            % If it exists, it should be deleted
            if (any(logi))
                %Construct Delete Record
                DeleteCount = DeleteCount + 1;           
                DeletedFeature(DeleteCount) = feaName2;
                DeletedFeatureId(DeleteCount) = staticFeatureID(feaId2);
                DeletedFeatureScore(DeleteCount) = feaRankScore2;
                DeletedBy(DeleteCount) = feaName1;
                DeletedById(DeleteCount) = staticFeatureID(feaId1);
                DeletedByScore(DeleteCount) = feaRankScore1;
                DeleteCounts(DeleteCount) = DeleteCount;
                PairCoeff(DeleteCount) = currentcoeff;
                
                %Delete the corresponding feature
                colId = find(logi);
                deleteFeature = dynamicColnames(colId);
                dynamicColnames(colId) = [];
                dynamicFeatureID(colId) = [];
                trn.X(colId,:) = [];
                tst.X(colId,:) = [];
                trn.dim = trn.dim - 1;
                tst.dim = tst.dim - 1;
                
                %delte coresponding row in the rank table
                feaRankDynamicIdx = find(strcmp(featureRankDynamicName,feaName2));
                T1(feaRankDynamicIdx,:) = [];
                featureRankDynamicName(feaRankDynamicIdx) = [];
            end
        else
            %--------------------------------------------------------------
            % Delete Feature 1
            % Check whether or not the current feature still exists.
            logi = strcmp(dynamicColnames,feaName1); 
            % If it exists, it should be deleted
            if (any(logi))
                %Construct Delete Record
                DeleteCount = DeleteCount + 1;           
                DeletedFeature(DeleteCount) = feaName1;
                DeletedFeatureId(DeleteCount) = staticFeatureID(feaId1);
                DeletedFeatureScore(DeleteCount) = feaRankScore1;
                DeletedBy(DeleteCount) = feaName2;
                DeletedById(DeleteCount) = staticFeatureID(feaId2);
                DeletedByScore(DeleteCount) = feaRankScore2;
                DeleteCounts(DeleteCount) = DeleteCount;
                PairCoeff(DeleteCount) = currentcoeff;
                
                %Delete the corresponding feature
                colId = find(logi);                
                deleteFeature = dynamicColnames(colId);
                dynamicColnames(colId) = [];
                trn.X(colId,:) = [];
                tst.X(colId,:) = [];
                trn.dim = trn.dim - 1;
                tst.dim = tst.dim - 1;
                
                %delte coresponding row in the rank table
                feaRankDynamicIdx = find(strcmp(featureRankDynamicName,feaName1));
                T1(feaRankDynamicIdx,:) = [];
                featureRankDynamicName(feaRankDynamicIdx) = [];
            end
        end
        fprintf(' %s (%d) : %f', feaName1, staticFeatureID(feaId1), feaRankScore1);
        fprintf(' %s (%d) : %f', feaName2, staticFeatureID(feaId2), feaRankScore2);
        fprintf(' --> Delete %s\n', deleteFeature);
    end
    % Remove the last row --> class/subject
    trn.X(end,:) = [];
    trn.dim = trn.dim - 1;
    tst.X(end,:) = [];
    tst.dim = tst.dim - 1;
    T2 = T1;
    save(info.rankPathAfter, 'T2');
    % Remove empty elements in the delete record
    DeleteCounts(DeleteCounts == 0) = [];    
    DeletedFeature = DeletedFeature(~strcmp(DeletedFeature,""));
    DeletedFeatureId(DeletedFeatureId == 0) = []; 
    DeletedFeatureScore(DeletedFeatureScore == 0) = []; 
    DeletedBy = DeletedBy(~strcmp(DeletedBy,""));
    DeletedById(DeletedById == 0) = []; 
    DeletedByScore(DeletedByScore == 0) = []; 
    PairCoeff(PairCoeff == 0) = []; 
    
    T3 = table(DeleteCounts, DeletedFeature, DeletedFeatureId, DeletedFeatureScore, DeletedBy, DeletedById, DeletedByScore, PairCoeff);
    save(info.rankPathDeleteRecord, 'T3');
    fprintf('===========================\n');
    fprintf('===%d Features Left========\n', trn.dim);
    fprintf('===========================\n');
end
