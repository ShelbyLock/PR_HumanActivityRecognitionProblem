function T1 = QualityRelevanceRank(des, colnames, featureID, info)
    %Get descriptive statistics Data
    var = [des.VAR{:, 1}]';
    skew = [des.SKEW{:, 1}]';
    kur = [des.KUR{:, 1}]';
    ranking = [des.RANK{:, 1}]';  
    ranking = ceil(ranking);
    
    numofFeatures = length(colnames) - 1;
    
    % Minimize Variance
    % Default of the sort function is ascend
    [~, varIndexSorted] = sort(var, 'ascend');
    
    % Skewness should be close to 0
    [~, skewIndexSorted] = sort(abs(skew), 'ascend');
    
    % Kurtosis should be close to 0
    [~, kurIndexSorted] = sort(abs(kur), 'ascend');
    
    % Kruskall-Wallis ranking should as high as possible
    [~, rankIndexSorted] = sort(ranking, 'descend');
    
    % Define Weigted Ratio
    importanceofVar = 0.1;
    importanceofSkew = 0.1;
    importanceofKur = 0.1;
    importanceofRank = 0.7;
    
    fullScore = 100;
    
    % Initialize the required variables
    Feature = colnames(1:(end-1))';
    FeatureIndex = zeros(numofFeatures,1);
    
    VarRank = zeros(numofFeatures,1);
    VarValue = zeros(numofFeatures,1);
    
    SkewRank = zeros(numofFeatures,1);
    SkewValue = zeros(numofFeatures,1);
    
    KurRank = zeros(numofFeatures,1);
    KurValue = zeros(numofFeatures,1);
    
    KWRank = zeros(numofFeatures,1);
    KWValue = zeros(numofFeatures,1);
    
    TotalRank = zeros(numofFeatures,1);
    %TotalRankScore = zeros(numofFeatures, 1);
    TotalRankScoreTemp = zeros(numofFeatures, 1);
    
    %Construct the TotalRankScore vector according to the original position
    %By original position I mean the sequence of features appearing in
    %colnames.
    for i = 1 : numofFeatures
        
        varSortedIndex = find(varIndexSorted == i);
        weightedVar = (fullScore - varSortedIndex + 1) * importanceofVar;
    
        skewSortedIndex = find(skewIndexSorted == i);
        weightedSkew = (fullScore - skewSortedIndex + 1) * importanceofSkew;
    
        kurSortedIndex = find(kurIndexSorted == i);
        weightedKur = (fullScore - kurSortedIndex + 1) * importanceofKur;
    
        rankSortedIndex = find(rankIndexSorted == i);
        weightedRank =(fullScore - rankSortedIndex + 1) * importanceofRank;
        
        %Record the weighted score
        TotalRankScoreTemp(i) = weightedVar + weightedSkew + weightedKur + weightedRank;
    end
    [totalScoreSorted, totalIndexSorted] = sort(TotalRankScoreTemp, 'descend');
    
    TotalRankScore = totalScoreSorted;
    for i = 1 : numofFeatures
        TotalRank(i) = i;
        
        %current Index can be seen as the current id of feature
        currentIndex = totalIndexSorted(i);
        
        %FeatureIndex(i) = currentIndex;
        FeatureIndex(i) = featureID(currentIndex);
        Feature(i) = colnames(currentIndex);
        
        VarRank(i) = find(varIndexSorted == currentIndex);
        VarValue(i) = var(currentIndex);
        
        SkewRank(i) = find(skewIndexSorted == currentIndex);
        SkewValue(i) = skew(currentIndex);
    
        KurRank(i) = find(kurIndexSorted == currentIndex);
        KurValue(i) = kur(currentIndex);
    
        KWRank(i) = find(rankIndexSorted == currentIndex);
        KWValue(i) = ranking(currentIndex); 
    end
     T1 = table(Feature, FeatureIndex, VarRank, VarValue, SkewRank, SkewValue, KurRank, KurValue, KWRank, KWValue, TotalRank, TotalRankScore);
     save(info.rankPathBefore, 'T1');
end