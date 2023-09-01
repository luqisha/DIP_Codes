
% ID: 190104140
% Group: C2

%% 1.1. Program for Histogram Equalization

input = imread("cameraman.png");
info = imfinfo("cameraman.png");
L = 2^ info.BitDepth;
[ROW, COL] = size(input);


graylevel = zeros(1, L);

% Computing no. of pixels for each grey level
for i = 1: ROW
    for j = 1: COL
        x = input(i, j) + 1;
        graylevel(x) = graylevel(x) + 1;
    end
end


% Computing PDF 
n = sum(graylevel);
PDF = graylevel/double(n);


% Computing CDF
CDF = zeros(1, L);

for i = 1: length(CDF)
    CDF(i) = sum(PDF(1, 1:i));
end


% Multiply CDF by L-1 and Round

NCDF = CDF * (L-1);
NCDF = round(NCDF);


% Generating output bit intensity
output = uint8(zeros(ROW, COL));

for i = 1: ROW
    for j = 1: COL
        x = input(i, j);
        y = NCDF(x);
        output (i, j) = y;
    end
end


% Display input & output images with histograms
figure;
subplot(4, 2, 1); 
imshow(input);
title('Input Image');

subplot(4, 2, 2); 
histogram(input(:), 256);
title('Histogram of Input');

subplot(4, 2, 3);
imshow(output);
title('Output Image');

subplot(4, 2, 4);
histogram(output(:), 256);
title('Histogram of Output Image');




%% 1.2. Histogram Specification using a different input image

ref_img = imread("starry_night.jpg");
ref_img = imresize(ref_img, [ROW, COL]);
ref_img = rgb2gray(ref_img);

ref_graylevel = zeros(1, L);

% Computing no. of pixels for each grey level of ref. image
for i = 1: ROW
    for j = 1: COL
        x = ref_img(i, j) + 1;
        ref_graylevel(1, x) = ref_graylevel(1, x) + 1;
    end
end

% Computing PDF of ref. image
n = sum(ref_graylevel);
ref_PDF = ref_graylevel/double(n);

% Computing CDF of ref. image
ref_CDF = zeros(1, L);

for i = 1: length(ref_CDF)
    ref_CDF(i) = sum(ref_PDF(1, 1:i));
end

% Multiply CDF by L-1 and Round
ref_NCDF = ref_CDF * (L-1);
ref_NCDF = round(ref_NCDF);

% Mapping input values to ref. image
mapped_intensity = uint8(zeros(1, L));
for i = 1: L
    temp = ref_NCDF( ref_NCDF >= NCDF(i) );
    mapped_intensity(i) = min(temp);
end

% Generating output bit intensity
spec_output = uint8(zeros(ROW, COL));

for i = 1: ROW
    for j = 1: COL
        x = input(i, j);
        y = mapped_intensity(x);
        spec_output (i, j) = y;
    end
end


% Display specified input & output images with histograms
subplot(4, 2, 5); 
imshow(ref_img);
title('Reference Image');

subplot(4, 2, 6); 
histogram(ref_img(:), 256);
title('Histogram of Reference Image');

subplot(4, 2, 7);
imshow(spec_output);
title('Output image after Histogram Specifiation');

subplot(4, 2, 8);
histogram(spec_output(:), 256);
title('Histogram of Output Image after Histogram Specifiation');

