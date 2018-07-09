function [ output_args ] = Untitled( img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%% initialize variables
% img is original gray image
img = rgb2gray(img);
% randpixel is random pixel count
randpixel = 0;
% size of original image
[R,C] = size(img);
% a 2D array for all original image pixel representation in encoded symbols set
arrimg = zeros(5000,R*C+1);
% a 1D array for all encoded symbols
arren = zeros(1,R*C*200);
% reconimg is reconstructed image
reconimg = zeros(R,C,1,'uint8');
% randimg is random pixel image
randimg = zeros(R,C,1,'uint8');

%% storing 2D image pixels in the 1st row of arrimg
j=1;
for r = 1:R
    for c = 1:C
        arrimg(1,j) = img(r,c);
        j = j+1;
    end
end
% element is the number of pixel of original image
element = j;

%% generating encoded symbols
% j is the index for encoded symbol set(arren)
j = 1;
max = 10;
% n is the number of pixel to be exored to generate 1 encoded symbol
for n = 1:max
    % loop is the number of how many sets of "n" pixel will generate encoded
    %symbols
    loop = randi(R*20);
    %if n == 1
       % loop = 1000;
   % end
    for L = 1:loop
        sum = 0;
        for i = 1:n
            randR = randi(R);
            randC = randi(C);
            % col is the random pixel index in arrimg
            col = randR*randC;
            if n == 1
                randpixel = randpixel + 1;
                randimg(randR,randC) = img(randR,randC);
            end
            sum = bitxor(sum, arrimg(1,col));
            %sum = sum + arrimg(1,col);
            % row is encoded symbol index number for a particular original element
            for row = 2:R*C
                if arrimg(row,col) == 0
                    arrimg(row,col) = j;
                    break;
                end
            end
        end
        arren(1,j) = sum;
        j = j + 1;
    end
end
disp(randpixel);
disp(R*C);
%% decoding to original image
for i = 1:element
    sum = 0;
    % loop is encoded symbol index number for a particular original element
    for loop = 2:R*C
        if arrimg(loop,i) == 0
            break;
        end
        index = arrimg(loop,i);
        %sum = sum + arren(1,index);
        sum = bitxor(sum,arren(1,index));
    end
    Row = ceil(i/C);
    if mod(i,C) == 0
        Col = C;
    else
        Col = mod(i,C);
    end
    reconimg(Row,Col) = sum;
end

%% show images
figure;
imshow(img); title('original image');
figure;
imshow(randimg); title(['random pixel image' num2str(randpixel/(R*C)*100) '%']);
figure;
imshow(reconimg); title('image after reconstruction');
end

