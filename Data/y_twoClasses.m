function num_activities = y_twoClasses(data_text)
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
    str_activities = strrep(str_activities,'B','2');
    str_activities = strrep(str_activities,'C','1');
    str_activities = strrep(str_activities,'D','1');
    str_activities = strrep(str_activities,'E','1');
    str_activities = strrep(str_activities,'F','1');
    str_activities = strrep(str_activities,'G','1');
    str_activities = strrep(str_activities,'H','1');
    str_activities = strrep(str_activities,'I','1');
    str_activities = strrep(str_activities,'J','1');
    str_activities = strrep(str_activities,'K','1');
    str_activities = strrep(str_activities,'L','1');
    str_activities = strrep(str_activities,'M','1');
    str_activities = strrep(str_activities,'O','1');
    str_activities = strrep(str_activities,'P','1');
    str_activities = strrep(str_activities,'Q','1');
    str_activities = strrep(str_activities,'R','1');
    str_activities = strrep(str_activities,'S','1');
    %split the string with comma, so that we get a array with activities names
    num_activities = strsplit(str_activities,',');
    num_activities = str2double(num_activities);
end
