function [trn, tst] = TrnTstData(data)
    x = data.X;
    y = data.y;
    TRAIN_PERCENTAGE = 0.8;
    
    tempTrn = cell(1,50);
    tempTrnY = cell(1,50);
    tempTst = cell(1,50);
    tempTstY = cell(1,50);
    
    total_trn_num = 0;
    total_tst_num = 0;
    
    for i = 1 : 50
        data_subject = 1600 + i;
        %data 1614 is missing, thus we need to skip it.
        if isempty(find(x(end,:) == data_subject))
            continue;
        end
        % Find all the data belonging to the current subject
        idx = find(x(end,:) == data_subject);
        subjectX = x(:,idx);
        subjectY = y(idx);
        
        lengthSegment = length(idx);
        trn_num = ceil(lengthSegment * TRAIN_PERCENTAGE);       
        tst_num = lengthSegment - trn_num;
        
        total_trn_num = total_trn_num + trn_num;
        total_tst_num = total_tst_num + tst_num;
        
        %Random sampling 
        all_idx = 1:lengthSegment;
        trn_idx = randsample(lengthSegment,trn_num);
        tst_idx = setdiff(all_idx,trn_idx');
        
        tempTrn{1,i} = subjectX(:, trn_idx);
        tempTrnY{1,i} = subjectY(trn_idx);
        
        tempTst{1,i} = subjectX(:, tst_idx);
        tempTstY{1,i} = subjectY(tst_idx);
    end
    tempTrn(cellfun(@isempty,tempTrn))=[];
    tempTrnY(cellfun(@isempty,tempTrnY))=[];
    
    tempTst(cellfun(@isempty,tempTst))=[];
    tempTstY(cellfun(@isempty,tempTstY))=[];
    
    [~, width] = size(tempTrn);
    preTrnX = zeros(data.dim, total_trn_num);
    preTrnY = zeros(1, total_trn_num);
    
    preTstX = zeros(data.dim, total_tst_num);
    preTstY = zeros(1, total_tst_num);
    
    trnStartCount = 1;
    trnEndCount = 0;
    
    tstStartCount = 1;
    tstEndCount = 0;
    
    for i = 1: width
       currentTrnX = tempTrn{1,i};
       currentTrnY = tempTrnY{1,i};
       currentTstX = tempTst{1,i};
       currentTstY = tempTstY{1,i};
       
       [~,trntempnum] = size(currentTrnX);
       
       trnEndCount = trnEndCount + trntempnum;
       preTrnX(:, trnStartCount: trnEndCount) = currentTrnX;
       preTrnY(trnStartCount: trnEndCount) = currentTrnY;
       trnStartCount = trnEndCount + 1; 
       
       [~,tstCurrentSize] = size(currentTstX);
       
       tstEndCount = tstEndCount + tstCurrentSize;
       preTstX(:, tstStartCount: tstEndCount) = currentTstX;
       preTstY(tstStartCount: tstEndCount) = currentTstY;
       tstStartCount = tstEndCount + 1;        
    end  
    
    trn.X = preTrnX;
    trn.y = preTrnY;
    trn.dim = data.dim;
    trn.num_data = total_trn_num;

    tst.X = preTstX;
    tst.y = preTstY;
    tst.dim = data.dim;
    tst.num_data = total_tst_num;    
end
