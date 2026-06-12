% trainIrisClassifier.m
% Bu betik, çıkarılan LBP özellikleri üzerinde bir Çok Katmanlı Algılayıcı (YSA)
% modeli eğitir ve test eder. Makaledeki gibi YSA tabanlı bir sınıflandırma gerçekleştirir.

clc; close all;

fprintf('--- İris Sınıflandırma (Yapay Sinir Ağı) ---\n');

% 1. Özelliklerin Yüklenmesi
if ~exist('allFeatures', 'var') || ~exist('allLabels', 'var')
    fprintf('Özellikler çalışma alanında (workspace) bulunamadı. prepareIrisDataset çalıştırılıyor...\n');
    prepareIrisDataset;
end

if isempty(allFeatures) || isempty(allLabels)
    error('Özellik veya etiket matrisi boş. Veri setini kontrol edin.');
end

% YSA (patternnet) girdi formatı: (Özellik Sayısı x Örnek Sayısı) şeklinde olmalı
inputs = allFeatures'; 

% Etiketleri One-Hot formatına çevirelim: (Sınıf Sayısı x Örnek Sayısı)
% patternnet sınıflandırmada çıktı olarak her sınıf için olasılık üretir.
targets = dummyvar(grp2idx(allLabels))'; 

% 2. YSA Modelinin Oluşturulması ve Veri Bölme
% Gizli katmandaki nöron sayısını belirliyoruz (Örn: 10 nöron)
hiddenLayerSize = 10; 
net = patternnet(hiddenLayerSize);

% Ağın veriyi bölme oranları (%80 Eğitim, %20 Test)
% Makinedeki rastgeleliği sabitlemek için rng kullanılabilir ancak patternnet
% eğitimini kendisi rastgele başlatır.
net.divideParam.trainRatio = 0.80;
net.divideParam.valRatio = 0.00;
net.divideParam.testRatio = 0.20;

% 3. Modelin Eğitimi
fprintf('Yapay Sinir Ağı modeli eğitiliyor. Lütfen bekleyin...\n');
% 'train' fonksiyonu hem modeli eğitir hem de veriyi verdiğimiz oranlarda böler.
[net, tr] = train(net, inputs, targets);

% 4. Modelin Test Edilmesi
fprintf('Model %%%d test verisi üzerinde değerlendiriliyor...\n', net.divideParam.testRatio * 100);
% Sadece test için ayrılan veriler üzerinde tahmin yapalım
testInputs = inputs(:, tr.testInd);
testTargets = targets(:, tr.testInd);
testOutputs = net(testInputs);

% En yüksek olasılıklı sınıf indekslerini bulalım
[~, testPredictionsIdx] = max(testOutputs);
[~, testTrueLabelsIdx]  = max(testTargets);

% Test seti doğruluğu (Accuracy)
accuracy = sum(testPredictionsIdx == testTrueLabelsIdx) / length(testTrueLabelsIdx) * 100;
fprintf('==> Test Seti Doğruluğu (Accuracy): %%%.2f\n', accuracy);

% 5. Görselleştirme (Karmaşıklık Matrisi - Confusion Matrix)
% Ağın tüm veri seti üzerindeki genel performansını görelim
allOutputs = net(inputs);
figure('Name', 'İris Sınıflandırma - Karmaşıklık Matrisi');
plotconfusion(targets, allOutputs);
title('Karmaşıklık Matrisi (Confusion Matrix) - Tüm Veri Seti');

fprintf('Sınıflandırma işlemi başarıyla tamamlandı. \nEğitilen model workspace''te "net" değişkeni olarak bulunmaktadır.\n');
