input_img = rgb2gray(uint8(input_img));
%im2double() by default converts the values into [0.0 to 1.0]. so we don't
%need to use mat2gray().
input_img = im2double(input_img);

figure;
imshow(input_img); title('gray image');

bmask = im2bw(input_img,graythresh(input_img));

figure;
imshow(bmask); title('binary mask');
