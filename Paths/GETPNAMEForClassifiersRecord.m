function info = GETPNAMEForClassifiersRecord(type, scenario, cmodel)
    recordPath = ['./Classifier/' scenario '/' cmodel '/Record/'];
    
    %Names and Paths for storing record
    recordFilename = [recordPath type cmodel '_' scenario '.mat'];
    recordName = [type cmodel '_' scenario 'Record'];
    
    info.recordFilename = recordFilename;
    info.recordName = recordName;
end