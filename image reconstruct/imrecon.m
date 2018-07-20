function [ output_args ] = Untitled( img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[row,col] = size(img);
randomsample = zeros(row,floor(col/3),3,'uint8');

figure;
imshow(img); title('original image');
%figure;
%imshow(randomsample); title('black image');

%Red = img(:,:,1);
%Gre = img(:,:,2);
%Blu = img(:,:,3);

%% 25 percent random sampled
pixel = 0;
randpixel = 0;
for r = 1:row
    for c = 1:col
        if mod(randi(100),10) == 0
            randomsample(r,c) = img(r,c);
            randpixel = randpixel + 1;
        end
        pixel = pixel + 1;
    end
end

disp(randpixel);
disp(pixel);
figure;
imshow(randomsample); title(['random sampled image' num2str(randpixel/pixel*100) '%']);
%% image restoration
for r = 1:row
    for c = 2:col
        if randomsample(r,c) == 0
            %randomsample(r,c) = randomsample(r,c-1);
            randomsample(r,c) = bitxor(randomsample(r,c),randomsample(r,c-1));
        end
    end
end

figure;
imshow(randomsample); title('image after restoration');

%Red = randomsample(:,:,1);
%Gre = randomsample(:,:,2);
%Blu = randomsample(:,:,3);

%noiseless(:,:,1) = medfilt2(Red, [2 2]);
%noiseless(:,:,2) = medfilt2(Gre, [2 2]);
%noiseless(:,:,3) = medfilt2(Blu, [2 2]);

%down = imresize(noiseless,0.25);

%randomsample(:,:,1) = datasample(Red,col/3);
%randomsample(:,:,2) = datasample(Gre,col/3);
%randomsample(:,:,3) = datasample(Blu,col/3);

%img = reshape(img,[row,col]);
%randomsample = randsample(randomsample,[row,col]);


%image(randomsample);


%figure;
%imshow(down); title('downsampled image');

end

