function visualizeSamplesOriginalVsProcessed(imds, numSamples)
%VISUALIZESAMPLESORIGINALVSPROCESSED Etiketli datastore'dan rastgele örnekleri karşılaştırır.
%
%   visualizeSamplesOriginalVsProcessed(imds)
%   visualizeSamplesOriginalVsProcessed(imds, numSamples)
%
%   imds      : ön işlemsiz (ham okuma) imageDatastore.
%   numSamples: gösterilecek örnek sayısı (varsayılan 4).

% --- Rapor maddesi (2. Veri Seti Hazırlama): görselleştirme ---
% Ön işlemin etkisini nesnel olarak yorumlayabilmek için aynı görüntünün ham
% (RGB griye indirgenmiş gösterim) ve işlenmiş hali yan yana sunulur; CLAHE sonrası
% lokal kontrast artışının iris dokusuna yansıması doğrudan gözlemlenebilir.

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
