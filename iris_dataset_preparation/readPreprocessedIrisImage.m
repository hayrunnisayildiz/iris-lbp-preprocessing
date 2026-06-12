function I = readPreprocessedIrisImage(imdsPP, k)

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
