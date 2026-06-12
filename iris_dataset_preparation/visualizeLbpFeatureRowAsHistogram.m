function visualizeLbpFeatureRowAsHistogram(featRow)
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
