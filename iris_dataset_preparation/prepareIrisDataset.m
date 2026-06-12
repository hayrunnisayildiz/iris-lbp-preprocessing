clear; clc; close all;
scriptDir = fileparts(mfilename('fullpath'));
imageRoot = fileparts(scriptDir);
rng(42, 'twister');
if ~isfolder(imageRoot)
    error(['Klasör bulunamadı: %s\n' ...
        'prepareIrisDataset.m içinde imageRoot değişkenini veri kökünüze göre düzenleyin.'], ...
        imageRoot);
end
imds = createLabeledIrisDatastore(imageRoot);
fprintf('Toplam görüntü: %d\n', irisDatastoreNumFiles(imds));
fprintf('Sınıflar: %s\n', strjoin(categories(imds.Labels), ', '));
imdsPP = transformToPreprocessedDatastore(imds);
visualizeSamplesOriginalVsProcessed(imds, 4);
[allFeatures, allLabels] = extractLbpFeaturesFromDatastore(imdsPP);
fprintf('Özellik matrisi allFeatures: %d görüntü × %d boyut\n', ...
    size(allFeatures, 1), size(allFeatures, 2));
if ~isempty(allFeatures)
    visualizeLbpFeatureRowAsHistogram(allFeatures(1, :));
end
fprintf('Beti tamamlandı. Workspace: allFeatures, allLabels, imds, imdsPP.\n');
