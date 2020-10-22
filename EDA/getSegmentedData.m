function [DATA, Y, SheetNames] = getSegmentedData(data)
    x = data.X;
    y = data.y;
    
    DATA = cell(1, 51);
    DATA{1,1} = x;
    
    Y = cell(1, 51);
    Y{1,1} = y;
    
    SheetNames = cell(1, 51);
    SheetNames{1,1} = 'All Data';
    
    index = 2;
    for i = 0 : 50
        data_subject = 1600 + i;
        %data 1614 is missing, thus we need to skip it.
        if isempty(find(x(end,:) == data_subject))
            continue;
        end
        idx = (x(end,:) == data_subject);
        DATA{1,index} = x(:,idx);
        Y{1,index} = y(idx);
        SheetNames{1,index} = ['subject' num2str(data_subject)];
        
        index = index + 1;
    end
    
    DATA(cellfun(@isempty,DATA))=[];
    Y(cellfun(@isempty,Y))=[];
    SheetNames(cellfun(@isempty,SheetNames))=[];
end