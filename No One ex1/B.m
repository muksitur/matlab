function [ output_args ] = threshold( input_args )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%a = im2bw(input_args,0.2);
%a = im2bw(input_args,0.3);
a = im2bw(input_args,0.4);
b = im2bw(input_args,0.5);
%a = im2bw(input_args,0.6);
%a = im2bw(input_args,0.7);
c = im2bw(input_args,graythresh(input_args));

%the output of this function will be the threshold image using graythresh()
output_args = c;

figure;
imshow(a); title('masking with 0.4 level threshold');

figure;
imshow(b); title('masking with 0.5 level threshold');

figure;
imshow(c); title('masking with graythresh');


%Threshold level less than 0.4 or greater than 0.5 doesn't look
%appropriate.

%Background and foreground can be inverted using 'imcomplement'(black to
%white and white to black). In conclusion, the results look pretty much
%satisfactory to us.


end

