function output = Untitled( input_img, map )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

grayImage = input_img;

%rgbImage = cat(3, grayImage, grayImage, grayImage);

%[IND,map] = rgb2ind(rgbImage,4);

colorImage = ind2rgb(grayImage, jet(256));

figure;
imshow(colorImage); title('color');

end

