
% ID: 190104140
% Group: C2

%% 2. Program for Contrast Stretching

I = imread("cameraman.png");
info = imfinfo("cameraman.png");
L = 2^ info.BitDepth;
[ROW, COL] = size(I);

A = min(I(:));
B = max(I(:));
D = B-A;
M = L-1;

% Applying Contrast Stretching eqn 

R = uint8(zeros(ROW, COL));
for i = 1: ROW
    for j = 1: COL
        R(i, j) = (double(I(i,j)-A)/double(D) * M) + A;
    end
end


% Computing no. of pixels for each grey level

inp_graylevel = zeros(1, L);
out_graylevel = zeros(1, L);

for i = 1: ROW
    for j = 1: COL
        x1 = I(i, j) + 1;
        inp_graylevel(x1) = inp_graylevel(x1) + 1;

        x2 = R(i, j) + 1;
        out_graylevel(x2) = out_graylevel(x2) + 1;
    end
end


% Display input & output images with histograms
figure;
subplot(2, 2, 1);
imshow(I);
title("Input Image");

subplot(2, 2, 2);
bar(inp_graylevel)
title("Histogram of Input Image");

subplot(2, 2, 3);
imshow(R);
title("Image after Contrast Stretching");

subplot(2, 2, 4);
bar(out_graylevel)
title("Histogram after Contrast Stretching)");
