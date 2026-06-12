function visualizeSamplesOriginalVsProcessed(imds, numSamples)

arguments
    imds
    numSamples (1,1) double {mustBeInteger, mustBePositive} = 4
end

nFiles = irisDatastoreNumFiles(imds);
n = min(numSamples, nFiles);
idx = randperm(nFiles, n);

figure('Name', 'Iris veri seti: orijinal vs. ön işleme', 'Color', 'w');

for k = 1:n
    I = readimage(imds, idx(k));
    J = preprocessIrisImage(I);

    subplot(n, 2, 2 * k - 1);
    imshow(rgb2gray(I));
    title(sprintf('Orijinal (gri) — %s', string(imds.Labels(idx(k)))));

    subplot(n, 2, 2 * k);
    imshow(J);
    title(sprintf('Ön işleme (CLAHE + [0,1]) — %s', string(imds.Labels(idx(k)))));
end

end
