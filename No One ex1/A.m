function [ output_args ] = encont( input_args )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

a = rgb2gray(input_args);
a = double(a);

figure;
subplot(1,2,1); imshow(a./255); title('gray image');
subplot(1,2,2); imhist(a./255);

%histogram of the gray image is spreaded between just below 0.6 and 0.85.

%own contrast stretching
low = min(a(:));
disp(low);
high = max(a(:));
disp(high);
[row,col] = size(a);

for R=1:row
    for C=1:col
        temp = (a(R,C)-low)./(high-low);
        a(R,C) = temp;
    end
end

%the built-in stretchlim funtion works fine but its not expected to use.
%b = imadjust(a, stretchlim(a), [0.0,1.0]);


output_args = a ;
figure;
subplot(1,2,1); imshow(a); title('image after contrast enhancement');
subplot(1,2,2); imhist(a);

%After stretching the contrast, the histogram is distributed between 0.05 and 0.92.

%end

