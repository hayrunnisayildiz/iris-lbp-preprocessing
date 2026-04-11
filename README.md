# Iris veri seti — ön işleme ve LBP özellik çıkarma

MATLAB ile iris görüntülerini yükler, CLAHE + gri tonlama ön işlemi uygular ve **Local Binary Patterns (LBP)** özelliklerini `allFeatures` matrisinde toplar.

## Gereksinimler

- MATLAB
- Image Processing Toolbox

## Kurulum

1. Bu depoyu klonlayın veya indirin.
2. PNG iris görüntülerinizi sınıf klasörleri altında toplayın (ör. `iris_images/Sol/`, `iris_images/Sağ/`).
3. `iris_dataset_preparation/prepareIrisDataset.m` içinde `imageRoot` yolunu veri kökünüze göre ayarlayın (varsayılan: üst dizinde `iris_images`).

## Çalıştırma

MATLAB’te `iris_dataset_preparation` klasörüne `cd` yapıp:

```matlab
prepareIrisDataset
```

Çıktılar: örnek ön işleme karşılaştırması, ilk görüntünün LBP vektörü grafiği; workspace’te `allFeatures`, `allLabels`, `imds`, `imdsPP`.

## Klasör yapısı

```
iris_dataset_preparation/
  prepareIrisDataset.m
  createLabeledIrisDatastore.m
  preprocessIrisImage.m
  transformToPreprocessedDatastore.m
  extractLbpFeaturesFromDatastore.m
  visualizeSamplesOriginalVsProcessed.m
  visualizeLbpFeatureRowAsHistogram.m
```
