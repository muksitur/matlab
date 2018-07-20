function [ output_args ] = filtering( input_args )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here


%input_args = double(input_args);

se = strel('square',3);
a = imopen(input_args,se);
b = imclose(input_args,se);

%own opening function(formula copied from Professor Rodehorst's lecture) using sequence of erosion and dilation
c = imdilate(imerode(input_args,se),se);
%own closing function(formula copied from Professor Rodehorst's lecture) using sequence of dilation and ersion
d = imerode(imdilate(input_args,se),se);

%dilation built in function
y = imdilate(input_args,se);
w = imerode(input_args,se);
%adding black border for erosion/dilation purpose. this gives us chance to
%start from pixel (2,2)
x = padarray(input_args,[1 1]);

%x = input_args;

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
                %disp(x(wr,wc));
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
                %disp(x(wr,wc));
            end
        end
        if sum == 9
            v(R,C) = 1;
        end

    end
end


output_args = z;
figure;
imshow(a); title('morphological opening by three pixel using built-in function');

figure;
imshow(b); title('morphological closing by three pixel using built-in function');

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

%our own function and the built-in matlab functions expectedly is giving
%similar results. Except that, we have a black border, which was added for
%the logical purpose of erodin/dilating each pixel.


end

