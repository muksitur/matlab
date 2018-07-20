function [ output_args ] = Untitled( noisy_image )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%noisy_double = double(noisy_image);
noisy_gray = rgb2gray(noisy_image);

Edge = edge(noisy_gray);

%R = noisy_image(:,:,1);
%G = noisy_image(:,:,2);
%B = noisy_image(:,:,3);

%noiseless(:,:,1) = medfilt2(R, [10 10]);
%noiseless(:,:,2) = medfilt2(G, [10 10]);
%noiseless(:,:,3) = medfilt2(B, [10 10]);

noiseless = medfilt2(noisy_gray, [10 10]);

[Gx, Gy] = imgradientxy(noisy_gray);

sharp = imsharpen(noiseless);
%sharp_gray = rgb2gray(sharp);
figure;
imshow(noisy_gray); title('noisy image');
figure;
imshow(noiseless); title('noiseless image');
figure;
imshow(sharp+(Edge*255)); title('sharp image');
figure;
imshow(Edge); title('edge');

end

