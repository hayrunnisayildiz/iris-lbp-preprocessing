%% Iris biyometri — Veri yükleme, ön işleme ve LBP özellik çıkarma
% Bu betik raporun "2. Veri Seti Hazırlama" ve "3. Özellik Çıkarma" akışını uygular.
%
% Kullanım:
%   1. addpath ile bu klasörü MATLAB yoluna ekleyin veya bu klasörde çalışın.
%   2. imageRoot değişkenini PNG'lerin bulunduğu kök klasöre ayarlayın.
%   3. prepareIrisDataset komutunu çalıştırın.

clear; clc; close all;

% --- Kullanıcı ayarı: iris PNG kök klasörü (Sol / Sağ veya kişi alt klasörleri) ---
% Örnek: '/Users/kullanici/veri/iris' veya fullfile(pwd, 'iris_images')
imageRoot = fullfile(pwd, 'iris_images');

% Görselleştirmede rastgele örnek seçimini tekrarlanabilir yapar
rng(42, 'twister');

if ~isfolder(imageRoot)
    error(['Klasör bulunamadı: %s\n' ...
        'prepareIrisDataset.m içinde imageRoot değişkenini veri kökünüze göre düzenleyin.'], ...
        imageRoot);
end

%% 1) Etiketli veri deposu
% Fonksiyon içi rapor notları: createLabeledIrisDatastore.m
imds = createLabeledIrisDatastore(imageRoot);

fprintf('Toplam görüntü: %d\n', imds.NumFiles);
fprintf('Sınıflar: %s\n', strjoin(categories(imds.Labels), ', '));

%% 2) Ön işleme (CLAHE, gri tonlama) — okuma sırasında uygulanır
% Fonksiyon içi rapor notları: preprocessIrisImage.m, transformToPreprocessedDatastore.m
imdsPP = transformToPreprocessedDatastore(imds);

%% 3) Örnek görselleştirme: orijinal (gri) | ön işleme
% Fonksiyon içi rapor notları: visualizeSamplesOriginalVsProcessed.m
visualizeSamplesOriginalVsProcessed(imds, 4);

%% 4) LBP özellik çıkarma — tüm görüntüler tek matriste
% Fonksiyon içi rapor notları: extractLbpFeaturesFromDatastore.m
[allFeatures, allLabels] = extractLbpFeaturesFromDatastore(imdsPP);

fprintf('Özellik matrisi allFeatures: %d görüntü × %d boyut\n', ...
    size(allFeatures, 1), size(allFeatures, 2));

%% 5) İlk görüntünün LBP özellik vektörünün histogram benzeri çubuk grafiği
% Fonksiyon içi rapor notları: visualizeLbpFeatureRowAsHistogram.m
if ~isempty(allFeatures)
    visualizeLbpFeatureRowAsHistogram(allFeatures(1, :));
end

fprintf(['Beti tamamlandı. Workspace: allFeatures, allLabels, imds, imdsPP.\n']);
