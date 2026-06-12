function imds = createLabeledIrisDatastore(imageRoot)

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

if irisDatastoreNumFiles(imds) == 0
    warning('createLabeledIrisDatastore:NoFiles', ...
        'Belirtilen kökte PNG bulunamadı: %s', imageRoot);
end

end
