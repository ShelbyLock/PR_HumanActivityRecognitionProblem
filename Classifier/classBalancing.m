function newTrn = classBalancing(trn)
    new_trn_idx_temp1 = randsample(find(trn.y == 1),sum(trn.y == 2));
    new_trn_idx_temp2 = find(trn.y == 2);
    new_trn_idx = sort([new_trn_idx_temp1, new_trn_idx_temp2]);
    newTrn = trn;
    newTrn.X = trn.X(:,new_trn_idx);
    newTrn.y = trn.y(new_trn_idx);
    newTrn.num_data = length(new_trn_idx);
end