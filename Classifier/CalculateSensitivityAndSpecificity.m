function [sensitivity, specificity] = CalculateSensitivityAndSpecificity(ypred,yreal)
    if length(unique(yreal')) > 2
        [sensitivity, specificity] = SSinMultiClass(ypred,yreal);
    else
        [sensitivity, specificity] = SSinTwoClass(ypred, yreal, 2);
    end
    format long g
    sensitivity = round(sensitivity*100,2);
    specificity = round(specificity*100,2);
end
function [sensitivity, specificity] = SSinTwoClass(ypred,yreal, positiveClassLabel)

    index_judged_positives = find(ypred == positiveClassLabel);
    index_real_positives = find(yreal == positiveClassLabel);
    length_index_judged_positives = length(index_judged_positives);
    length_index_real_positives = length(index_real_positives);
    count_true_positives = 0;

    for i1 = 1 : length_index_real_positives
        for i2 = 1 : length_index_judged_positives
            if (index_real_positives(i1) == index_judged_positives(i2))
                count_true_positives = count_true_positives + 1;
            end
        end
    end
    count_false_positives = length_index_judged_positives - count_true_positives;

    index_judged_negatives = find(ypred ~= positiveClassLabel);
    index_real_negatives = find(yreal ~= positiveClassLabel);
    length_index_judged_negatives = length(index_judged_negatives);
    length_index_real_negatives = length(index_real_negatives);
    count_true_negatives = 0;

    for i3 = 1 : length_index_real_negatives
        for i4 = 1 : length_index_judged_negatives
            if (index_real_negatives(i3) == index_judged_negatives(i4))
                count_true_negatives = count_true_negatives + 1;
            end
        end
    end
    count_false_negatives = length_index_judged_negatives - count_true_negatives;

    %Calculate sensitivity
    sensitivity = (count_true_positives)/(count_true_positives+count_false_negatives);
    specificity = (count_true_negatives)/(count_true_negatives+count_false_positives);
end

function [sensitivity, specificity] = SSinMultiClass(ypred,yreal)
    n_classes = length(unique(yreal'));
    totalSensitivity = 0;
    totalSpecificity = 0;
    for classLabel = 1 : n_classes
        [currentSensitivity, currentSpecificity] = SSinTwoClass(ypred,yreal, classLabel);
        fprintf("For Class %d, Sensitivity is %.2f, Specificity is  %.2f \n", classLabel, currentSensitivity, currentSpecificity);
        totalSensitivity = totalSensitivity + currentSensitivity;
        totalSpecificity = totalSpecificity + currentSpecificity;
    end
    sensitivity = totalSensitivity/n_classes;
    specificity = totalSpecificity/n_classes;
end