function PlotEigval(model,info)
    
    ti1 = info.vTitleEigval;
    ti2 = info.vTitleEigvalSumVariance;
    filename1 = info.vFilenameEigval;
    filename2 = info.vFilenameEigvalSumVariance;
    
    figure; plot(model.eigval,'o')
    title(ti1)
    xlabel('PCA')
    ylabel('Eig. Value')
    saveas(gcf,filename1);
    
    total_variance=sum(model.eigval);
    
    figure; plot(cumsum(model.eigval)./total_variance*100, 'o');
    title(ti2)
    xlabel('PCA')
    ylabel('% of variance')
    saveas(gcf,filename2);
end