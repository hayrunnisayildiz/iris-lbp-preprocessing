function imds = createLabeledIrisDatastore(imageRoot)
%CREATELABELEDIRISDATASTORE Iris PNG'lerini etiketleriyle birlikte yükler.
%
%   imds = createLabeledIrisDatastore(imageRoot)
%
%   imageRoot: 'Sol' / 'Sağ' veya kişi klasörlerinin bulunduğu kök dizin (char/string).
%
%   Çıktı imds: imageDatastore nesnesi; her dosyanın etiketi, üst klasör adından türetilir.

% --- Rapor maddesi (2. Veri Seti Hazırlama) ---
% imageDatastore, görüntü dosya yollarını ve okuma mantığını tek nesnede toplar.
% 'IncludeSubfolders', true ile alt klasörlerdeki tüm PNG dosyaları taranır.
% 'LabelSource', 'foldernames' seçeneği, her görüntünün sınıf etiketini doğrudan
% bulunduğu alt klasör adından atar; böylece dosya adına manuel etiket yazmaya
% gerek kalmaz ve klasör yapısı veri etiketlemesiyle birebir uyumludur.

arguments
    imageRoot (1,:) char
end

if ~isfolder(imageRoot)
    error('createLabeledIrisDatastore:InvalidPath', ...
        'Geçerli bir klasör yolu girin: %s', imageRoot);
end

imds = imageDatastore(imageRoot, ...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames', ...
    'FileExtensions', '.png');

if imds.NumFiles == 0
    warning('createLabeledIrisDatastore:NoFiles', ...
        'Belirtilen kökte PNG bulunamadı: %s', imageRoot);
end

end
