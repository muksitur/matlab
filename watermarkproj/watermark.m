function [ output_args ] = Untitled( img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% all variables are initialized here

% img is the original image
% message is the payload
message = zeros(1,8001);
% R,C is the size of original image
[R,C] = size(img);
% arrindexmsg is the random index array of the pixels
arrindexmsg = zeros(1,8001);
% embedseq is the sequential embedded image
embedseq = img;
%embedrand is random embedded image
embedrand = img;

bluorigin = img(:,:,3);


%lsborigin = img(:,:,3);
%lsbseq = img(:,:,3);
%lsbrand = img(:,:,3);

%blu_embedseq = img(:,:,3);

%blu_embedrand = img(:,:,3);
% B is the blue channel of original image. this is used for sequential embedding 
B = img(:,:,3);
% b is another blue channel of original image. this is used for random
% embedding
b = img(:,:,3);
%% generating random 8000 bit sequence. this is part 2(a)

for i = 1:8000
    r = randi(2);
    r = r - 1;
    message(1,i) = r;
    %disp(message(1,i));
end

%% embedding the payload sequentially into the blue channel of the original image. this is part 2(b)

for r = 1:R
    for c = ((C/3)*2)+1:C
        col = c-((C/3)*2);
        i = (r-1)*C/3 + col;
        if i > 8000
            break;
        end
        % tampering only the blue channel of original image
        if message(1,i) == 1
            %this tampering is to make it visible. the actual tampering is
            %in the following line, which is commented.
            %B(r,col) = 255;
            B(r,col) = bitxor(1,B(r,col),'uint8');
        end
    end
end
% embedding B channel into the blue channel of embedseq
embedseq(:,:,3) = B;

%% embedding the payload randomly into the blue channel of the original image. this part is 2(c)

for i = 1:8000
    newrand = 0;
    randR = randi(R);
    randC = randi(C/3);
    
    for j = 1:i
        if arrindexmsg(1,j) == randR*randC
            newrand = 1;
            i = i - 1;
            break;
        end
    end
    
    if newrand == 1
        continue;
    end
    arrindexmsg(1,i) = randR*randC;
    % tampering random pixel only from the blue channel of original image
    if message(1,i) == 1
        %this tampering is to make it visible. the actual tampering is
        %in the following line, which is commented.
        %b(randR,randC) = 255;
        b(randR,randC) = bitxor(1,b(randR,randC),'uint8');
    end
    
end
% embedding b channel into the blue channel of embedrand
embedrand(:,:,3) = b;


%% lsb images 
lsborigin = double(bitget(img(:,:,3),1));
lsbseq = double(bitget(embedseq(:,:,3),1));
lsbrand = double(bitget(embedrand(:,:,3),1));

%disp(lsborigin);

%
%% show image results
figure;
imshow(message); title('payload');

figure;
imshow(img); title('original image');

figure;
imshow(embedseq); title('sequentially embedded image');

figure;
imshow(embedrand); title('randomly embedded image');

figure;
subplot(3,1,1); imhist(bluorigin); title('original image histogram');
subplot(3,1,2); imhist(B); title('sequential embedded image histogram');
subplot(3,1,3); imhist(b); title('random embedded image histogram');

figure;
subplot(1,3,1); imshow(lsborigin); title('original lsb image');
subplot(1,3,2); imshow(lsbseq); title('sequentially embedded lsb image');
subplot(1,3,3); imshow(lsbrand); title('randomly embedded lsb image');


end

