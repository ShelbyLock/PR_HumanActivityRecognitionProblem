function des = DescriptiveStatsCalculation(data, colnames, info)
    [DATA, Y, SheetNames] = getSegmentedData(data);
    [~, width] = size(DATA);
    
    MEAN_TEMP = cell(data.dim, width);
    MAX_TEMP = cell(data.dim, width);
    MIN_TEMP = cell(data.dim, width);
    STD_TEMP = cell(data.dim, width);
    VAR_TEMP = cell(data.dim,width);
    SKEW_TEMP = cell(data.dim,width);
    KUR_TEMP = cell(data.dim,width);
    RANK_TEMP = cell(data.dim,width);
    %total
    for i = 1:data.dim-1
        for j = 1 : width
            %Prepare for normalization
            currentdata = DATA{:, j};
            
            currenty = Y{:, j};
            %Mean
            MEAN_TEMP{i, j} =mean(currentdata(i,:));
            %MAX
            MAX_TEMP{i, j} =max(currentdata(i,:));
            %MIN
            MIN_TEMP{i, j} =min(currentdata(i,:));
            %std
            STD_TEMP{i, j} =std(currentdata(i,:));
            %Variance
            VAR_TEMP{i, j} =var(currentdata(i,:));
            %SKEWNESS
            SKEW_TEMP{i, j}  = skewness(currentdata(i,:));
            %Kurtosis
            KUR_TEMP{i, j}  = kurtosis(currentdata(i,:));
            % Kruskall-Wallis
            [~,atab,~]=kruskalwallis(currentdata(i,:),currenty,'off');
            RANK_TEMP{i, j} = atab{2, 5};
        end      
    end
    FEATURES = colnames(1:end-1);
    FEATURES = FEATURES';
    for i = 1 : width
        
        MEAN = [MEAN_TEMP{:,i}];
        MEAN = MEAN';
        
        MAX = [MAX_TEMP{:,i}];
        MAX = MAX';
        
        MIN = [MIN_TEMP{:,i}];
        MIN = MIN';
       
        STD= [STD_TEMP{:,i}];
        STD = STD';
        
        VAR = [VAR_TEMP{:,i}];
        VAR = VAR';
        
        SKEW = [SKEW_TEMP{:,i}];
        SKEW = SKEW';
        
        KUR = [KUR_TEMP{:,i}];
        KUR = KUR';
        
        RANK = [RANK_TEMP{:,i}];
        RANK = RANK';
        
        % Save all descriptive stats in an .xlsx file 
        T = table(FEATURES, MEAN, MAX, MIN, STD, VAR, SKEW, KUR, RANK);
        writetable(T, info.desXlsPath,'Sheet', SheetNames{1,i})
    end
    des.CORMATRIX = corrcoef(data.X(1:end-1,:)');
    des.MEAN = MEAN_TEMP;
    des.MAX = MAX_TEMP;
    des.Min = MIN_TEMP;
    des.STD = STD_TEMP;
    des.VAR = VAR_TEMP;
    des.SKEW = SKEW_TEMP;
    des.KUR = KUR_TEMP;
    des.RANK = RANK_TEMP;
    
    % Save the general descriptive stats in an .mat file 
    desName = info.desName;
    S.(desName) = des;
    save(info.desMatPath,'-struct' ,'S')
    clear S;
end