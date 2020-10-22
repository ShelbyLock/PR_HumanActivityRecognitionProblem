function data_scale = scaledstd(input)
    data = input.X;
    dim=size(data,1);
    num=size(data,2);
    %Normalize data
    mean_matrix = zeros(3,1);
    std_matrix = zeros(3,1);
    for i = 1: dim
        mean_matrix(i) = mean(data(i,:));
        std_matrix(i) = std(data(i,:));
    end

    data_scale.X = zeros(dim, num);
    data_scale.y = input.y;
    data_scale.dim = dim;
    data_scale.num_data = num;
    assert(dim == input.dim);
    assert(num == input.num_data)
    for i2 = 1: dim
        for i3 = 1: num
            data_scale.X(i2, i3) = (data(i2, i3) - mean_matrix(i2))/std_matrix(i2);
        end
    end
end