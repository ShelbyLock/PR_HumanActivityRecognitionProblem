function [COL_NAMES, dataA, dataB, dataC] = DataStruct(prefix, suffix)
    %Get column names
    str_text_arr_temp = '';
    example_identifier='00';
    path=[prefix example_identifier suffix];
    SOURCE = importdata(path);
    for i1 = 3 : 94
        data_columns = convertCharsToStrings(SOURCE.textdata{i1, 1});
        str_text_arr_temp = strcat(str_text_arr_temp,data_columns);
    end
    str_new = strrep(str_text_arr_temp,'@attribute "','');  %Replace the unnessasary info
    str_new = strrep(str_new,'" numeric',','); %Replace the unnessasary info and insert comma
    str_new = strrep(str_new,'" { 1600 }',''); %Replace the unnessasary info
    %split the string with comma, so that we get a array with feature/attributes names
    COL_NAMES = strsplit(str_new,',');
    
    TEMP_DATA = SOURCE.data;
    TEXT_DATA = SOURCE.textdata;
    DATA.X = TEMP_DATA';
    %Get the y data for scenarios A , B and C
    DATA.y1 = y_twoClasses(TEXT_DATA);
    DATA.y2 = y_threeClasses(TEXT_DATA);
    DATA.y3 = y_eighteenClasses(TEXT_DATA);
    for i = 1 : 50
        if i >= 1 && i < 10
            example_identifier = ['0',num2str(i)];
        else
            example_identifier = num2str(i);
        end
        %data 1614 is missing, thus we need to skip it.
        if i == 14
            continue;
        end
        path=[prefix example_identifier suffix];
        SOURCE = importdata(path);
        TEMP_DATA = SOURCE.data;
        TEXT_DATA = SOURCE.textdata;
        DATA.X = [DATA.X TEMP_DATA'];
        %Get the y data for scenarios A , B and C
        DATA.y1 = [DATA.y1 y_twoClasses(TEXT_DATA)];
        DATA.y2 = [DATA.y2 y_threeClasses(TEXT_DATA)];
        DATA.y3 = [DATA.y3 y_eighteenClasses(TEXT_DATA)];
    end
    DATA.dim = size(DATA.X, 1);
    DATA.num_data = size(DATA.X, 2);
    %assert(DATA.num_data == length(DATA.y));
    
    dataA.X = DATA.X;
    dataB.X = DATA.X;
    dataC.X = DATA.X;
    
    dataA.y = DATA.y1;
    dataB.y = DATA.y2;
    dataC.y = DATA.y3;
    
    dataA.dim = DATA.dim;
    dataB.dim = DATA.dim;
    dataC.dim = DATA.dim;
    
    dataA.num_data = DATA.num_data;
    dataB.num_data = DATA.num_data;
    dataC.num_data = DATA.num_data;
end
