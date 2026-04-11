function imdsOut = transformToPreprocessedDatastore(imds)
%TRANSFORMTOPREPROCESSEDDATASTORE Ön işleme zincirini datastore okumasına bağlar.
%
%   imdsOut = transformToPreprocessedDatastore(imds)
%
%   transform, okuma anında preprocessIrisImage uygular; tüm eğitim/test
%   döngülerinde aynı ön işlemin garanti edilmesini sağlar.

% --- Rapor maddesi (2. Veri Seti Hazırlama): transform ---
% imageDatastore.transform, okunan her örneğe kullanıcı tanımlı fonksiyonu uygular;
% böylece ön işleme bellekte tek kopya tutulmadan, ihtiyaç duyuldukça (lazy)
% çalıştırılabilir ve diskte ayrı klasör tutma zorunluluğu kalkar.

imdsOut = transform(imds, @preprocessIrisImage);

end
