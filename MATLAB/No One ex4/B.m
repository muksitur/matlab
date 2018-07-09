function [] = B(a,b)
    
    %a = imread('training.png');
    %we are mirroring training.png
    %a = flipdim(a,2);
    [a1, a2]=fourdes(a);
    %b = imread('test1B.jpg');
    [b1, b2]=fourdes(b);
    
    %c = imread('test2B.jpg');
    figure; imshow(b2); title('test image');
    hold on;
    [r1,c1]=size(a1);
    [r2,c2]=size(b1);
    %matching between trainingB.png and test1B.jpg
    for m=1:c1
        d1=a1(:,m);
        for e=1:c2
            d2=b1(:,e)
            d=norm(d1-d2);
            % this if condition is when any of the boundaries match. match
            % found
            if(d<1)
                %d3 = ifft(d2);
                %plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2),
                [B,L] = bwboundaries(b2,'noholes');
                boundary = B{e};
                plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
            %each unmatched boundaries is detected here.
            else
                [B,L] = bwboundaries(b2,'noholes');
                boundary = B{e};
                plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2);
            end
        end
    end
    % matching between trainingB.png and test2B.jpg
    %fourier descriptor doesn't work on test2B.jpg. we don't know why
    %[z1, z2]=fourdes(c);
    %figure; imshow(b2); title('test image');
    %hold on;
    %[r3,c3]=size(z1);
    %for m=1:c1
    %    d1=a1(:,m);
    %    for e=1:c3
    %        d2=b1(:,e)
    %        d=norm(d1-d2);
    %        % this if condition is when any of the boundaries match
    %       if(d<0.06)
                %d3 = ifft(d2);
                %plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2),
    %            [B,L] = bwboundaries(b2,'noholes');
    %            boundary = B{e};
    %            plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
            %eac
     %       h unmatched boundaries is detected here.
     %       else
     %          [B,L] = bwboundaries(b2,'noholes');
     %           boundary = B{e};
     %           plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2);
     %       end
     %   end
   % end
    
    

end

function [ out1, out2 ] = fourdes( input_img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

input_img = rgb2gray(uint8(input_img));
%im2double() by default converts the values into [0.0 to 1.0]. so we don't
%need to use mat2gray().
input_img = im2double(input_img);

figure;
imshow(input_img); title('gray image');

bmask = im2bw(input_img,graythresh(input_img));

figure;
imshow(bmask); title('binary mask');

[B,L] = bwboundaries(bmask,'noholes');
imshow(label2rgb(L, @jet, [.5 .5 .5]))
hold on
%n=24 is too much for test1B.png and test2B.png. we don't know why. So, we are choosing n = 4
n =4;

a=rand(n,length(B))
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2),
   D=boundary(:,2)+j*boundary(:,1);
   df=fft(D);
   dff = df(2:n+1);
   dff = dff/abs(dff(2));
   dff = abs(dff);
   a(1:n,k)=dff;  
end

out1 = a;
out2 = bmask;

end
