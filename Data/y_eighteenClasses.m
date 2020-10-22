function num_activities = y_eighteenClasses(data_text)
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
    str_activities = strrep(str_activities,'C','3');
    str_activities = strrep(str_activities,'D','4');
    str_activities = strrep(str_activities,'E','5');
    str_activities = strrep(str_activities,'F','6');
    str_activities = strrep(str_activities,'G','7');
    str_activities = strrep(str_activities,'H','8');
    str_activities = strrep(str_activities,'I','9');
    str_activities = strrep(str_activities,'J','10');
    str_activities = strrep(str_activities,'K','11');
    str_activities = strrep(str_activities,'L','12');
    str_activities = strrep(str_activities,'M','13');
    str_activities = strrep(str_activities,'O','14');
    str_activities = strrep(str_activities,'P','15');
    str_activities = strrep(str_activities,'Q','16');
    str_activities = strrep(str_activities,'R','17');
    str_activities = strrep(str_activities,'S','18');
    %split the string with comma, so that we get a array with activities names
    num_activities = strsplit(str_activities,',');
    num_activities = str2double(num_activities);
end
