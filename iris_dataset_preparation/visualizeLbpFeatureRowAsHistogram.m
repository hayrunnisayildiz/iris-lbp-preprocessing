function visualizeLbpFeatureRowAsHistogram(featRow)
%VISUALIZELBPFEATUREROWASHISTOGRAM Tek bir LBP özellik satırını çubuk grafik olarak gösterir.
%
%   visualizeLbpFeatureRowAsHistogram(featRow)
%
%   featRow: 1xD veya Dx1 vektör; extractLBPFeatures çıktısının bir görüntüye ait özeti.

% --- Rapor maddesi (3. Özellik Çıkarma): histogram görselleştirme ---
% extractLBPFeatures çıktısı, görüntü (ve isteğe bağlı hücre ayrımı) boyunca LBP kodlarının
% yoğunluk dağılımını temsil eden sayısal bir vektördür. Bin indekslerine karşı çubuk grafik,
% ilk görüntünün doku özetinin hangi kod aralıklarında yoğunlaştığını raporda tartışmayı kolaylaştırır.

arguments
    featRow (:,:) double
end

v = featRow(:);
if isempty(v)
    return
end

figure('Name', 'LBP özellik vektörü (1. görüntü)', 'Color', 'w');
bar(1:numel(v), v);
xlabel('Özellik indeksi (histogram bin)');
ylabel('Değer');
title('İlk görüntünün LBP özellik vektörü');

grid on;

end
