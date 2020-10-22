function [dynamicTrn,dynamicTst,dynamicColnames, featureID, covPair] = correlationStatsExamination(trn, tst, colnames, featureID, des)
    dynamicTrn = trn;
    dynamicTst = tst;
    dynamicColnames = colnames;
    
    % We only want to measure the "magnitude" of coefficient. 
    % Therefore, I take the absolute values.
    matrix = des.CORMATRIX;
    matrix = abs(matrix); 
    d = length(matrix);
    %num = ((d*d)-d)/2; 
    count = 1;
    
    %Remove Features that has only one value
    for i = 1 : (d-1)
       for j = (i+1) : d
            covPairFea1 = colnames(i);
            covPairFea2 = colnames(j);
            %IF the correlation coefficient is not NaN, I store the 
            %information of current feature pair
            %ELSE I delete one/both of feature(s) because at least one of
            %them has erroneous value (e.g. only has one value.)
            if ~isnan(matrix(i,j))
                covPairTemp{1, count} = covPairFea1;
                covPairTemp{2, count} = covPairFea2;
                covPairTemp{3, count} = matrix(i,j);
                count = count + 1;
            else
                %fprintf("Correlation Coefficient Between %s ID %d",colnames(i),i);
                %fprintf(" and %s ID %d is NaN.\n",colnames(j),j);
                
                temp1 = sum((trn.X(i,:) == mean(trn.X(i,:))))/(trn.num_data);
                temp2 = sum((trn.X(j,:) == mean(trn.X(j,:))))/(trn.num_data);
                
                logiIdx1 = find(strcmp(dynamicColnames,covPairFea1));
                if (temp1 > 0.8) && ~isempty(logiIdx1)
                    fprintf('Delete Feature %s (ID %d) because its value is incorrect.\n', covPairFea1, i);
                    %remove ID
                    featureID(logiIdx1) = [];
                    
                    dynamicColnames(logiIdx1) = [];
                    dynamicTrn.X(logiIdx1,:) = [];
                    dynamicTrn.dim = dynamicTrn.dim - 1;
                    dynamicTst.X(logiIdx1,:) = [];
                    dynamicTst.dim = dynamicTst.dim - 1;
                end
                logiIdx2 = find(strcmp(dynamicColnames,covPairFea2));
                if (temp2 > 0.8) && ~isempty(logiIdx2)
                    fprintf('Delete Feature %s (ID %d) because its value is incorrect.\n', covPairFea2, j);
                    %remove ID
                    featureID(logiIdx2) = [];
                    
                    dynamicColnames(logiIdx2) = [];
                    dynamicTrn.X(logiIdx2,:) = [];
                    dynamicTrn.dim = dynamicTrn.dim - 1;
                    dynamicTst.X(logiIdx2,:) = [];
                    dynamicTst.dim = dynamicTst.dim - 1;
                end
            end
       end
    end
    fprintf('====================================================================\n');
    fprintf('===I have %d Features before, now there are %d Features Left========\n', trn.dim-1, dynamicTrn.dim-1);
    fprintf('====================================================================\n');
    %covPair(cellfun(@isempty,covPair));
    covPair = covPairTemp;
end