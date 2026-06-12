function imdsOut = transformToPreprocessedDatastore(imds)
imdsOut = transform(imds, @preprocessIrisImage);
end
