
% ID: 190104140
% Group: C2

%% Program for interleaving two images into 6 columns

img1 = imread("image1.jpeg");
img2 = imread("image2.jpeg");

imfinfo("image1.jpeg")
imfinfo("image2.jpeg")

img1 = imresize(img1, [1200,1200]);
img2 = imresize(img2, [1200,1200]);

img1 = rgb2gray(img1);
img2 = rgb2gray(img2);

%% Solution 1 %%
% col1 = img1(:, 1:200);
% col2 = img2(:, 201:400);
% col3 = img1(:, 401:600);
% col4 = img2(:, 601:800);
% col5 = img1(:, 801:1000);
% col6 = img2(:, 1001:end);
% 
% output = [col1, col2, col3, col4, col5];

%% Solution 2 %%
% output = uint8(zeros(1200,1200));
% 
% for i= 0:5
%     for j = 1:200
%         if rem(i, 2) == 0
%             output(1:end, j+(200*i)) = img1(1:end, j+(200*i));
%         else 
%             output(1:end, j+(200*i)) = img2(1:end, j+(200*i));
%         end
%     end
% end

%% Solution 3 %%
output = uint8(zeros(1200,1200));

for i = 0:5
    if rem(i, 2) == 0
        output(:, (i*200)+1 : (i+1)*200) = img1(:, (i*200)+1 : (i+1)*200);
    else 
        output(:, (i*200)+1 : (i+1)*200) = img2(:, (i*200)+1 : (i+1)*200);
    end
end

%% Showing Output
imwrite(output, "output.jpeg");
imshow(output);
