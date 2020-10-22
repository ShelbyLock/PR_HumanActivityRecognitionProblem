function info = GETPNAMEForClassifiersFigures(type, scenario, cmodel)
    %Write it on 28 of May
    figurePath = './Classifier/BestModelRecords/';
    
    %Names and Paths for storing record
    confuseFilename = [figurePath type cmodel '_' scenario 'ConfusionMatrix.fig'];
    confuseName = [type cmodel '_' scenario 'ConfusionMatrix'];
    
    info.confuseFilename = confuseFilename;
    info.confuseName = confuseName;
end