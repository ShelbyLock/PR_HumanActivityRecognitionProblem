function ComparePCAandLDA(pca_z,lda_z, info)
    ti1 = info.vTitlePCACompare;
    ti2 = info.vTitleLDACompare;
    filename = info.vFilenamePCALDACompare;
    
    %figure; hold on;
    %subplot(2,1,1); title(ti1); ppatterns(pca_z);
    %subplot(2,1,2); title(ti2); ppatterns(lda_z);
    %saveas(gcf,filename);
    
    plotBivariatePPatterns(pca_z, lda_z, ti1, ti2, filename);
end

%Bivariable Analysis
function plotBivariatePPatterns(data1, data2, ti1, ti2, patternName)
    if data1.dim > 5
        data1.dim = 5;
    end
    count = 0;
    for i = 1 : (data1.dim - 1)
       for j = (i+1) : (data1.dim) 
        count = count + 1;
        
        currentData1 = data1;
        currentData1.X = currentData1.X([i j],:);
        currentData1.dim = 2;
        
        currentData2 = data2;
        currentData2.X = currentData2.X([i j],:);
        currentData2.dim = 2;

        newPatternName = [patternName 'Count' num2str(count) '.fig'];
        figure; hold on;
        subplot(2,1,1); title([ti1 ' Plot Count ' num2str(count)]); ppatterns(currentData1);
        subplot(2,1,2); title([ti2 ' Plot Count ' num2str(count)]); ppatterns(currentData2);
        saveas(gcf,newPatternName);
        clear newPatternName;
       end
    end
end