function [featMat, labelVec, refSzUsed] = extractLbpFeaturesFromDatastore(imdsPP, refSzIn)
%EXTRACTLBPFEATURESFROMDATASTORE Ön işlemeli datastore'dan LBP özellik vektörleri çıkarır.
%
%   [featMat, labelVec] = extractLbpFeaturesFromDatastore(imdsPP)
%   [featMat, labelVec, refSzUsed] = extractLbpFeaturesFromDatastore(imdsPP, refSzIn)
%
%   imdsPP : transform ile ön işlemeli imageDatastore.
%   refSzIn: isteğe bağlı [H W]; boşsa bu datastore'daki ilk görüntünün boyutu referans alınır.
%   featMat: NxD double; her satır bir görüntünün LBP histogram/özellik vektörü.
%   labelVec: Nx1 categorical; imdsPP.Labels ile aynı sıra.
%   refSzUsed: kullanılan [H W] (rapor/çoğaltma için üçüncü çıktı).
%
%   Görüntü boyutları referanstan farklıysa imresize ile hizalanır.

% --- Rapor maddesi (3. Özellik Çıkarma): LBP koduna dönüşüm ---
% Klasik LBP akışı: her piksel için merkez yoğunluk referans alınır; örneğin dairesel
% komşuluk (P nokta, yarıçap R) üzerindeki her komşu, merkezden büyük veya eşitse 1,
% küçükse 0 ikili değeri alır. Bu ikili dizinin ağırlıklı toplamı o pikselin LBP kodudur;
% böylece lokal doku (iris kripta/çizgi yapısı) komşuluk ilişkileriyle sayısallaşır.
% Ardından görüntü (veya alt hücreler) boyunca bu kodların histogramı hesaplanır; böylece
% uzamsal yerleşim özetlenerek sabit boyutlu bir özellik vektörü elde edilir.
% MATLAB extractLBPFeatures, bu süreci uygular; hücreleme ve komşuluk parametreleri
% isteğe bağlı ayarlanabilir. Image Processing Toolbox gerektirir.

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
        % --- Rapor notu: boyut normalizasyonu ---
        % Farklı çözünürlüklerde LBP histogram uzunluğu değişeceğinden, tek tip vektör
        % uzunluğu için referans boyuta yeniden örnekleme (imresize) uygulanır.
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
