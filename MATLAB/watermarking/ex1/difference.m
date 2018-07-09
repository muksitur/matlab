function [ output_args ] = Untitled( original, hidden1, hidden2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%original = rgb2gray(original);
%hidden1 = rgb2gray(hidden1);
%hidden2 = rgb2gray(hidden2);

[row,col] = size(original);

pixdif1 = 0;
pixdif2 = 0;
totpix = 0;

for r = 1:row
    for c = 1:col
        if original(r,c) ~= hidden1(r,c)
            pixdif1 = pixdif1 + 1;
        end
        
        if original(r,c) ~= hidden2(r,c)
            pixdif2 = pixdif2 + 1;
        end
        
        totpix = totpix + 1;
    end
end


disp(pixdif1/totpix*100);
disp(pixdif2/totpix*100);

R1 = hidden1(:,:,1);
G1 = hidden1(:,:,2);
B1 = hidden1(:,:,3);

hiddenrecon1(:,:,1) = medfilt2(R1, [3 3]);
hiddenrecon1(:,:,2) = medfilt2(G1, [3 3]);
hiddenrecon1(:,:,3) = medfilt2(B1, [3 3]);


R2 = hidden2(:,:,1);
G2 = hidden2(:,:,2);
B2 = hidden2(:,:,3);

hiddenrecon2(:,:,1) = medfilt2(R2, [3 3]);
hiddenrecon2(:,:,2) = medfilt2(G2, [3 3]);
hiddenrecon2(:,:,3) = medfilt2(B2, [3 3]);


pixdif1 = 0;
pixdif2 = 0;
totpix = 0;

for r = 1:row
    for c = 1:col
        if original(r,c) ~= hiddenrecon1(r,c)
            pixdif1 = pixdif1 + 1;
        end
        
        if original(r,c) ~= hiddenrecon2(r,c)
            pixdif2 = pixdif2 + 1;
        end
        
        totpix = totpix + 1;
    end
end


disp(pixdif1/totpix*100);
disp(pixdif2/totpix*100);


figure;
imshow(original); title('original');

figure;
imshow(hidden1); title('hidden image 1');

figure;
imshow(hidden2); title('hidden image 2');

figure;
imshow(hiddenrecon1); title('hidden reconstructed image 1');

figure;
imshow(hiddenrecon2); title('hidden reconstructed image 2');

%disp(totpix);

end

