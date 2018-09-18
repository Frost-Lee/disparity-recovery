%read the image

image1 = double(imread('batinria0.tif'));
image2 = double(imread('batinria1.tif'));

nPoints = 12;

[x1, y1, x2, y2] = getpoints2();

figure
imshow(uint8(image1));
hold on
plot(x1, y1, 'r+');
hold off

figure
imshow(uint8(image2));
hold on
plot(x2, y2, 'r+');
hold off

% Intrinsic camera parameter matrices
K1 = [844.310547 0 243.413315; 0 1202.508301 281.529236; 0 0 1];
K2 = [852.721008 0 252.021805; 0 1215.657349 288.587189; 0 0 1];

% compute an approximation of the essential matrix

% construct the Ki matrix

% Attention! The coordinate we will use as x1, x2 are not IMAGE COORDINATE!
% But a 3-D point, but according to the set of the PREIMAGE, we can regard
% the z-axis of x1, x2 as 1, just to modify lambda

% compute X
for i=1:nPoints
    l = K1^-1 * [x1(i), y1(i), 1]';
    r = K2^-1 * [x2(i), y2(i), 1]';
    % without a typical lambda, we just got the X with the z-axis as 1
    x1(i) = l(1);
    y1(i) = l(2);
    x2(i) = r(1);
    y2(i) = r(2); 
end

Ki = zeros(12, 9);
for i=1:nPoints
    a = kron([x1(i), y1(i), 1]', [x2(i), y2(i), 1]');
    Ki(i, :) = a(:);
end



    



