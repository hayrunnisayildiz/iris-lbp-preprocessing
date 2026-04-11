function J = preprocessIrisImage(I)
%PREPROCESSIRISIMAGE RGB iris görüntüsünü gri, CLAHE ve [0,1] double'a dönüştürür.
%
%   J = preprocessIrisImage(I)
%
%   I: HxWx3 uint8/double RGB iris görüntüsü.
%   J: HxW double, aralık [0,1]; gri, yerel kontrast güçlendirilmiş.

% --- Rapor maddesi (2. Veri Seti Hazırlama): rgb2gray ---
% Renkli iris görüntüleri sınıflandırma ve doku analizi için tek kanala indirgenir.
% rgb2gray, insan görsel sistemine yakın ağırlıklarla luminance bileşenini üretir;
% böylece pigment farklarından ziyade parlaklık/yapı bilgisi öne çıkar.

G = rgb2gray(I);

% --- Rapor maddesi (2. Veri Seti Hazırlama): adapthisteq (CLAHE) ---
% Global histogram eşitleme tüm görüntüye tek eşleme uyguladığından gürültüyü
% artırabilir. adapthisteq, görüntüyü bölgelere ayırıp her bölgede kontrast
% sınırlı histogram eşitleme (Contrast Limited Adaptive Histogram Equalization)
% uygular; iris üzerindeki kripta ve radyal çizgiler gibi ince dokular daha
% seçilebilir hale gelir ('ClipLimit' ve 'NumTiles' ihtiyaca göre ayarlanabilir).

G = adapthisteq(G, 'NumTiles', [8 8], 'ClipLimit', 0.02);

% --- Rapor maddesi (2. Veri Seti Hazırlama): im2double ---
% im2double, uint8 [0,255] değerlerini [0,1] aralığına ölçekler. Bu, sonraki
% aşamalarda (filtreleme, derin öğrenme girişi, ortalama/standart sapma ile
% parlaklık normalizasyonu) sayısal kararlılık ve tutarlı ölçek sağlar.

J = im2double(G);

end
