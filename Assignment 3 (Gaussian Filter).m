
% ID: 190104140
% Group: C2

%% Implementation of Gaussian Filter

I = imread("mrbean.jpg");
I = rgb2gray(I);

sigma = input("Enter value of sigma: ");

% Designing the 3x3 kernel
X = [-1 0 1; -1 0 1; -1 0 1];
Y = [-1 -1 -1; 0 0 0; 1 1 1];

kernel = exp((-1.*(X.^2 + Y.^2)) ./ (2*sigma^2)) ./ (2*pi*sigma^2);

% Padding input image
input_padded = double(padarray(I, [1,1]));

% Applying Filter to input image
[ROW, COL] = size(I);
output = zeros([ROW, COL]);

for i = 1: ROW
    for j = 1: COL
        temp  = input_padded(i:i+2, j:j+2) .* kernel;
        output(i,j) = sum(temp(:));
    end
end

% Writing output image 
output = uint8(output);
imwrite(output, "mrbean_blurred.jpg");

figure;
subplot(1,2,1);
imshow(I);
title("Input Image");

subplot(1,2,2);
imshow(output);
title(["Output Image with sigma = " num2str(sigma)]);
