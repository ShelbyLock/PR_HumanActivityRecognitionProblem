function PlotConfusionMatrix(YTest, YPredicted,tit)
    %YTest = YTest - 1;
    %YPredicted = YPredicted - 1;
    %figure;
    %plotconfusion(YTest,YPredicted)
    %title(tit);
    [FP,FN] = roc(YTest, YPredicted);
    figure; hold on; plot(FP, FN);
    title(tit);
    xlabel('false positives'); 
    ylabel('false negatives');
end