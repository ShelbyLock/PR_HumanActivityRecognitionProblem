% Perform LDA
function [Z, XR, model] = PerformLDA(data, new_dim)

    X = data.X;
    model = lda(data, new_dim);    %Train PCA
    Z = linproj(data, model);    %Lower dim. proj
    XR = pcarec(X, model);    %Reconstruct Data
    Z.dim = new_dim;
    Z.num_data = data.num_data;
end