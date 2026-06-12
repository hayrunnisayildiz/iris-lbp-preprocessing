function [featMat, labelVec, refSzUsed] = extractLbpFeaturesFromDatastore(imdsPP, refSzIn)

arguments
    imdsPP
    refSzIn = []
end

n = irisDatastoreNumFiles(imdsPP);
if n == 0
    featMat = zeros(0, 0);
    labelVec = categorical([]);
    refSzUsed = [];
    return
end

I1 = readPreprocessedIrisImage(imdsPP, 1);
I1 = toGray2d(I1);
if isempty(refSzIn)
    refSzUsed = size(I1);
else
    refSzUsed = double(refSzIn(:).');
    if numel(refSzUsed) ~= 2 || any(refSzUsed < 1) || any(mod(refSzUsed, 1) ~= 0)
        error('extractLbpFeaturesFromDatastore:InvalidRefSz', 'refSzIn pozitif tamsayı [H W] olmalıdır.');
    end
end
if ~isequal(size(I1), refSzUsed)
    I1 = imresize(I1, refSzUsed);
end
refSz = refSzUsed;

feat1 = extractLBPFeatures(I1);
d = numel(feat1);
featMat = zeros(n, d, 'like', feat1);
labelVec = imdsPP.Labels;

featMat(1, :) = feat1(:).';

for i = 2:n
    I = readPreprocessedIrisImage(imdsPP, i);
    I = toGray2d(I);
    if ~isequal(size(I), refSz)
        I = imresize(I, refSz);
    end
    f = extractLBPFeatures(I);
    featMat(i, :) = f(:).';
end

end

function G = toGray2d(I)
if size(I, 3) == 1
    G = I(:, :, 1);
else
    G = rgb2gray(I);
end
end
