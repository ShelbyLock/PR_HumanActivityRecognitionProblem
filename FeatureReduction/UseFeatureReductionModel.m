function Z = UseFeatureReductionModel(data, model, new_dim)
    Z = linproj(data, model);    %Lower dim. proj
    Z.dim = new_dim;
    Z.num_data = data.num_data;
end