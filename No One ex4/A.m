function [ output_args ] = Untitled( input_img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

clc
close all

input_img = rgb2gray(uint8(input_img));
%im2double() by default converts the values into [0.0 to 1.0]. so we don't
%need to use mat2gray().
input_img = im2double(input_img);
%input_img = mat2gray(input_img, [0.0 1.0]);

figure;
imshow(input_img); title('Gray image');
%disp(fft(input_img));
figure;
%imagesc(log(abs(fftshift(fft2(input_img))))); title('original spectra');
imagesc(log(abs(fftshift(fft(input_img))))); title('original spectra');

noise = imnoise(input_img,'gaussian',0,0.01);

figure;
imshow(noise); title('noisy image');

%figure;
%imagesc(log(abs(fftshift(noise)))); title('noisy spectra');
%gfilt = imgaussfilt(noise,2);


%gaussian filter window size is 200 and sigma 2.
window = 200
sigma = 2;
ind = -floor(window/2):floor(window/2);
[x y] = meshgrid(ind,ind);
h = exp(-(x.^2+y.^2)/(2*sigma*sigma))/(2*pi*sigma*sigma);
%h = h/sum(h(:));

%h = fspecial('gaussian',[window window],sigma);

builtgauss = imgaussfilt(noise,sigma);
figure;
imshow(builtgauss); title('builtgauss');
fftnoise = fft2(noise);
figure;
%imagesc(log(abs(fftshift(fftnoise)))); title('fftnoise');
imagesc(log(abs(fftnoise))); title('fftnoise');
[r c] = size(noise);
zero = zeros(r,c);

for row = 1:window
    for col = 1:window
       zero(row,col) = h(row,col); 
    end
end
circ = circshift(zero, [-floor(window/2) -floor(window/2)]);
figure;
imshow(circ, []); title('circ');

fftpad = fft2(circ);
figure;
imshow(fftpad); title('fftpad');
figure;
%imagesc(log(abs(fftshift(fftpad)))); title('padding spectra');
imagesc(log(abs(fftpad))); title('padding spectra');
%convolution was causing the problem
%convolv = conv2(fftnoise,fftpad);
%the problem was fixed after elementwise multiplication
convolv = fftnoise.*fftpad;
invfft = ifft2(convolv);


figure;
imshow(invfft); title('filtered');
figure;
%imagesc(log(abs(fftshift(fft2(invfft))))); title('filtered spectra');
imagesc(log(abs(fft2(invfft)))); title('filtered spectra');

end

