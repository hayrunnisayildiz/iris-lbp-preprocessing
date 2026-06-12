function n = irisDatastoreNumFiles(ds)

n = [];
if isprop(ds, 'NumFiles')
    try
        n = ds.NumFiles;
    catch
        n = [];
    end
end
if ~isempty(n)
    return
end

if isprop(ds, 'Files')
    n = numel(ds.Files);
    return
end

if isprop(ds, 'UnderlyingDatastores') && ~isempty(ds.UnderlyingDatastores)
    n = irisDatastoreNumFiles(ds.UnderlyingDatastores{1});
    return
end

if isprop(ds, 'UnderlyingDatastore')
    n = irisDatastoreNumFiles(ds.UnderlyingDatastore);
    return
end

error('irisDatastoreNumFiles:Unsupported', ...
    'Bu datastore tipi için dosya sayısı türetilemedi.');

end
