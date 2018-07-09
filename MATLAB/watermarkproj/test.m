function [ output_args ] = Untitled( img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%gray = rgb2gray(img);

gray = fi([2 3 4;6 8 2;3 5 1],0,4,0);
disp(bin(gray));

c = bitget(gray,2);
disp(c);

figure;
imshow(c); title('blah blah');
end

