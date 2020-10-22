function info = GETPNAMEForClassifiersModel(type, scenario, cmodel, rmodel, dim,runcount)
    modelPath = ['./Classifier/' scenario '/' cmodel '/Model/'];
    
    %Names and Paths for storing model
    modelFilename = [modelPath type cmodel 'Modelwith' rmodel num2str(dim) '_' num2str(runcount) '_' scenario '.mat'];
    modelName = [type cmodel 'Modelwith' rmodel num2str(dim) '_' num2str(runcount) '_' scenario];
    
    info.modelFilename = modelFilename;
    info.modelName = modelName;
end