clc; close all;
fprintf('--- İris Sınıflandırma (Yapay Sinir Ağı) ---\n');
if ~exist('allFeatures', 'var') || ~exist('allLabels', 'var')
    fprintf('Özellikler çalışma alanında (workspace) bulunamadı. prepareIrisDataset çalıştırılıyor...\n');
    prepareIrisDataset;
end
if isempty(allFeatures) || isempty(allLabels)
    error('Özellik veya etiket matrisi boş. Veri setini kontrol edin.');
end
inputs = allFeatures';
targets = dummyvar(grp2idx(allLabels))';
hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize);
net.divideParam.trainRatio = 0.80;
net.divideParam.valRatio = 0.00;
net.divideParam.testRatio = 0.20;
fprintf('Yapay Sinir Ağı modeli eğitiliyor. Lütfen bekleyin...\n');
[net, tr] = train(net, inputs, targets);
fprintf('Model %%%d test verisi üzerinde değerlendiriliyor...\n', net.divideParam.testRatio * 100);
testInputs = inputs(:, tr.testInd);
testTargets = targets(:, tr.testInd);
testOutputs = net(testInputs);
[~, testPredictionsIdx] = max(testOutputs);
[~, testTrueLabelsIdx]  = max(testTargets);
accuracy = sum(testPredictionsIdx == testTrueLabelsIdx) / length(testTrueLabelsIdx) * 100;
fprintf('==> Test Seti Doğruluğu (Accuracy): %%%.2f\n', accuracy);
allOutputs = net(inputs);
figure('Name', 'İris Sınıflandırma - Karmaşıklık Matrisi');
plotconfusion(targets, allOutputs);
title('Karmaşıklık Matrisi (Confusion Matrix) - Tüm Veri Seti');
fprintf('Sınıflandırma işlemi başarıyla tamamlandı. \nEğitilen model workspace''te "net" değişkeni olarak bulunmaktadır.\n');
