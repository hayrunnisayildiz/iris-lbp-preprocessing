function I = readPreprocessedIrisImage(imdsPP, k)
%READPREPROCESSEDIRISIMAGE Ön işlemeli görüntüyü okur (tüm MATLAB sürümleri / datastore tipleri).
%
%   Yeni sürümlerde readimage(transform(ds)) desteklenir; eskilerde alt imageDatastore
%   üzerinden readimage / imread + preprocessIrisImage ile aynı çıktı üretilir.

try
    I = readimage(imdsPP, k);
    return
catch
end

base = [];
if isprop(imdsPP, 'UnderlyingDatastores') && ~isempty(imdsPP.UnderlyingDatastores)
    base = imdsPP.UnderlyingDatastores{1};
elseif isprop(imdsPP, 'UnderlyingDatastore')
    base = imdsPP.UnderlyingDatastore;
end

if isempty(base)
    error('readPreprocessedIrisImage:NoUnderlying', ...
        'transform edilmiş datastore için alt imageDatastore bulunamadı (indeks %d).', k);
end

try
    Iraw = readimage(base, k);
catch
    if isprop(base, 'Files') && k >= 1 && k <= numel(base.Files)
        Iraw = imread(base.Files{k});
    else
        error('readPreprocessedIrisImage:ReadFailed', ...
            'Görüntü okunamadı (indeks %d).', k);
    end
end

I = preprocessIrisImage(Iraw);
end
