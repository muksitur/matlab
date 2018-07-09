function [ output_args ] = Untitled( img1,img2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
img1 = imresize(img1, [35 35]);
img2 = imresize(img2, [35 35]);

[row1,col1] = size(img1);
[row2,col2] = size(img2);
%gray1 = rgb2gray(img1);
%gray2 = rgb2gray(img2);
%disp(row);
%disp(col);

disc1 = zeros(row1,floor(col1/3),3,'uint8');
disc2 = zeros(row2,floor(col2/3),3,'uint8');

disc1(:,:,1) = dct2(img1(:,:,1));
disc1(:,:,2) = dct2(img1(:,:,2));
disc1(:,:,3) = dct2(img1(:,:,3));

disc2(:,:,1) = dct2(img2(:,:,1));
disc2(:,:,2) = dct2(img2(:,:,2));
disc2(:,:,3) = dct2(img2(:,:,3));

%dctgray1 = dct2(gray1);
%dctgray2 = dct2(gray2);
disp(img1(:,:,1));
disp(disc1(:,:,1));
%disp(dctgray2);
%disp(img1(:,:,3));
%disp(disc1(:,:,3));

%disp(img2(:,:,3));
%disp(disc2(:,:,3));

%mulconst = 1;
%addconst = 50;

%testmul(:,:,1) = temp(:,:,1)*mulconst;
%testmul(:,:,2) = temp(:,:,2)*mulconst;
%testmul(:,:,3) = temp(:,:,3)*mulconst;

%testadd(:,:,1) = temp(:,:,1)+addconst;
%testadd(:,:,2) = temp(:,:,2)+addconst;
%testadd(:,:,3) = temp(:,:,3)+addconst;

%testmul(:,:,1) = idct2(testmul(:,:,1));
%testmul(:,:,2) = idct2(testmul(:,:,2));
%testmul(:,:,3) = idct2(testmul(:,:,3));

%testadd(:,:,1) = idct2(testadd(:,:,1));
%testadd(:,:,2) = idct2(testadd(:,:,2));
%testadd(:,:,3) = idct2(testadd(:,:,3));

%figure;
%imshow(original); title('image before');

figure;
subplot(4,1,1); imhist(disc1(:,:,1)); title('dct test 01 red channel');
subplot(4,1,2); imhist(disc2(:,:,1)); title('dct test 02 red channel');
subplot(4,1,3); imhist(img1(:,:,1)); title('test 01 red channel');
subplot(4,1,4); imhist(img2(:,:,1)); title('test 02 red channel');

figure;
subplot(4,1,1); imhist(disc1(:,:,2)); title('dct test 01 green channel');
subplot(4,1,2); imhist(disc2(:,:,2)); title('dct test 02 green channel');
subplot(4,1,3); imhist(img1(:,:,2)); title('test 02 green channel');
subplot(4,1,4); imhist(img2(:,:,2)); title('test 02 green channel');

figure;
subplot(4,1,1); imhist(disc1(:,:,3)); title('dct test 01 blue channel');
subplot(4,1,2); imhist(disc2(:,:,3)); title('dct test 02 blue channel');
subplot(4,1,3); imhist(img1(:,:,3)); title('test 02 blue channel');
subplot(4,1,4); imhist(img2(:,:,3)); title('test 02 blue channel');

end

