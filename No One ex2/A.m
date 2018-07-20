function [ output_args ] = Untitled( input_img)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

a = input_img;
input_img = rgb2gray(input_img);
figure;
imshow(input_img); title('Gray image');
input_img = double(input_img);
%input_img = mat2gray(input_img, [0.0 1.0]);
figure;
imshow(input_img); title('Gray image(0.0 to 1.0)');
% for the value sigma = 0.5 the mask looks different from the mask shown in
% exercise sheet.
       w = 5;sigma=0.5; % window,st.dev
       f = fspecial('gaussian', [w w], sigma);
       [Gx,Gy] = gradient(f);
       
       %disp(Gx);
       %disp(Gy);
       
       
       %[Ix, Iy]=gradient(double(input_img),sigma);
       %G = imfilter(input_img,[Ix,Iy]);
       %[Ix, Iy]=gradient(double(input_img),sigma);
       
       %[Ix, Iy] = gradient(input_img);
       %[Gx, Gy] = imgradientxy(input_img);
       
       %input_img = input_img(:);
       %Gx = Gx(:);
       %Gy = Gy(:);
       %Ix = conv(input_img, Gx);
       
       %Iy = conv(input_img, Gy);
       
       %disp(Ix);
       %disp(Iy);
       m=medfilt2(input_img, [10 10]);
       [row,col] = size(m);
       for R=3:row-2
           for C=3:col-2
               sumX = 0;
               sumY = 0;
               for u=-2:2
                   for v=-2:2
                       Ix(R,C)=Gx(u+3,v+3)*m(R-u,C-v);
                       sumX = sumX + Ix(R,C);
                       
                       Iy(R,C)=Gy(u+3,v+3)*m(R-u,C-v);
                       sumY = sumY + Iy(R,C);
                   end
               end
               Ix(R,C) = sumX;
               Iy(R,C) = sumY;
           end
       end
       
           
       
       G=sqrt(Ix.^2+Iy.^2);
       
       %disp(G);
       Ix = imsharpen(Ix);
       Iy = imsharpen(Iy);
       figure;
       imshow(Ix,[]); title('Gradient in X direction');
       
       figure;
       imshow(Iy,[]); title('Gradient in Y direction');
       
       figure;
       imshow(G); title('Gradient magnitude using convolution');
       
       %original input image, Ix and Iy is passed to function B as parameter.
       B(a,Ix,Iy);

end

