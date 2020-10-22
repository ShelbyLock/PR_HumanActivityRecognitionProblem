% Perform PCA
function [Z, XR, model] = PerformPCA(data, new_dim)
    X = data.X;
    model = pca(X, new_dim);    %Train PCA
    Z = linproj(data, model);    %Lower dim. proj
    XR = pcarec(X, model);    %Reconstruct Data
    Z.dim = new_dim;
    Z.num_data = data.num_data;
end