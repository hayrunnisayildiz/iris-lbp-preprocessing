function J = preprocessIrisImage(I)

G = rgb2gray(I);

G = adapthisteq(G, 'NumTiles', [8 8], 'ClipLimit', 0.02);

J = im2double(G);

end
