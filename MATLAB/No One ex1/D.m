function [ output_args ] = encont_thresh_filt( input_args )
%UNTITLED6 Summary of this function goes here
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
        temp = (a(R,C)-low)*(255/(high-low))+0;
        a(R,C) = temp;
    end
end

%the built-in stretchlim funtion works fine but its not expected to use.
%b = imadjust(a, stretchlim(a), [0.0,1.0]);


Aout = a./255 ;

figure;
subplot(1,2,1); imshow(a./255); title('image after contrast enhancement');
subplot(1,2,2); imhist(a./255);

%After stretching the contrast, the histogram is distributed between 0.05 and 0.92.


%a = im2bw(input_args,0.2);
%a = im2bw(input_args,0.3);
a = im2bw(Aout,0.4);
b = im2bw(Aout,0.5);
%a = im2bw(input_args,0.6);
%a = im2bw(input_args,0.7);
c = im2bw(Aout,graythresh(Aout));

%the output of this function will be the threshold image using graythresh()
Bout = c;

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

se = strel('square',3);
a = imopen(Bout,se);
b = imclose(Bout,se);

%own opening function(formula copied from Professor Rodehorst's lecture) using sequence of erosion and dilation
c = imdilate(imerode(Bout,se),se);
%own closing function(formula copied from Professor Rodehorst's lecture) using sequence of dilation and ersion
d = imerode(imdilate(Bout,se),se);

%dilation built in function
y = imdilate(Bout,se);
w = imerode(Bout,se);

%adding black border for erosion/dilation purpose. this gives us chance to
%start from pixel (2,2)
x = padarray(Bout,[1 1]);
%x = Bout;
%dilation own function
[row,col] = size(x);
figure;
imshow(x); title('before dilation');
%output_args = x;
for R = 2:row-1
    for C = 2:col-1
        sum = 0;
        for wr = R-1:R+1
            for wc = C-1:C+1
                sum = sum + x(wr,wc);
                
            end
        end
        if sum > 0
            z(R,C) = 1;
        end

    end
end
%erosion own function
for R = 2:row-1
    for C = 2:col-1
        sum = 0;
        for wr = R-1:R+1
            for wc = C-1:C+1
                sum = sum + x(wr,wc);
                
            end
        end
        if sum == 9
            v(R,C) = 1;
        end

    end
end

output_args = z;
figure;
imshow(a); title('morphological opening using built-in function');

figure;
imshow(b); title('morphological closing using built-in function');

figure;
imshow(c); title('opening using own function');

figure;
imshow(d); title('closing using own function');

figure;
imshow(z); title('dilation own function');

figure;
imshow(y); title('dilation built-in function');

figure;
imshow(v); title('erosion own function');

figure;
imshow(w); title('erosion built-in function');

%our own function and the built-in matlab functions are expectedly giving
%similar results. Except that, we have a black border, which was added for
%the logical purpose of erodin/dilating each pixel.

end

