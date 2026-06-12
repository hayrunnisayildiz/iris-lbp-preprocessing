function features = my_extractLBPFeatures(I)
    I = double(I);
    [m, n] = size(I);
    lbp_image = zeros(m, n);
    for i = 2:m-1
        for j = 2:n-1
            center = I(i, j);
            code = 0;
            code = code + (I(i-1, j-1) >= center) * 128;
            code = code + (I(i-1, j)   >= center) * 64;
            code = code + (I(i-1, j+1) >= center) * 32;
            code = code + (I(i, j+1)   >= center) * 16;
            code = code + (I(i+1, j+1) >= center) * 8;
            code = code + (I(i+1, j)   >= center) * 4;
            code = code + (I(i+1, j-1) >= center) * 2;
            code = code + (I(i, j-1)   >= center) * 1;
            lbp_image(i, j) = code;
        end
    end
    lbp_image = lbp_image(2:m-1, 2:n-1);
    features = histcounts(lbp_image(:), 0:256);
    if sum(features) > 0
        features = features / sum(features);
    end
end
