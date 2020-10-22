function num_activities = y_threeClasses(data_text)
    str_activities = '';
    data_columns = convertCharsToStrings(data_text{96, 1});
    str_activities = strcat(str_activities,data_columns);
    for i2 = 97 : numel(data_text)
        data_columns = convertCharsToStrings(data_text{i2, 1});
        str_activities = strcat(str_activities,',');
        str_activities = strcat(str_activities,data_columns);
    end
    %str_activities = str_activities(1:end-1); %delete the last comma
    str_activities = strrep(str_activities,'A','1');
    str_activities = strrep(str_activities,'B','1');
    str_activities = strrep(str_activities,'C','1');
    str_activities = strrep(str_activities,'D','1');
    str_activities = strrep(str_activities,'E','1');
    str_activities = strrep(str_activities,'F','2');
    str_activities = strrep(str_activities,'G','2');
    str_activities = strrep(str_activities,'H','3');
    str_activities = strrep(str_activities,'I','3');
    str_activities = strrep(str_activities,'J','3');
    str_activities = strrep(str_activities,'K','3');
    str_activities = strrep(str_activities,'L','3');
    str_activities = strrep(str_activities,'M','1');
    str_activities = strrep(str_activities,'O','2');
    str_activities = strrep(str_activities,'P','2');
    str_activities = strrep(str_activities,'Q','2');
    str_activities = strrep(str_activities,'R','2');
    str_activities = strrep(str_activities,'S','2');
    %split the string with comma, so that we get a array with activities names
    num_activities = strsplit(str_activities,',');
    num_activities = str2double(num_activities);
end