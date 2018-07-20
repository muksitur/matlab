function [ output_args ] = Untitled( input_img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
input_img = rgb2gray(uint8(input_img));
%im2double() by default converts the values into [0.0 to 1.0]. so we don't
%need to use mat2gray().
input_img = im2double(input_img);
%input_img = mat2gray(input_img, [0.0 1.0]);

figure;
imshow(input_img); title('Gray image');

%showing gray image
%figure;
%imshow(input_img); title('Gray image');
% for the value sigma = 0.5 the mask looks different from the mask shown in
% exercise sheet.
       w = 5;sigma=0.5; % window,st.dev
       f = fspecial('gaussian', [w w], sigma);
       [Gx,Gy] = gradient(f);
       
       m=input_img;
       [row,col] = size(m);
       for R=3:row-2
           for C=3:col-2
               sumX = 0;
               sumY = 0;
               for u=-2:2
                   for v=-2:2
                       Ix(R,C)=Gx(u+3,v+3)*m(R-u,C-v);
                       sumX = sumX + Ix(R,C);
                       
                       Iy(R,C)=Gy(u+3,v+3)*m(R-u,C-v);
                       sumY = sumY + Iy(R,C);
                   end
               end
               Ix(R,C) = sumX;
               Iy(R,C) = sumY;
           end
       end
       
           
       
       G=sqrt(Ix.^2+Iy.^2);
       
       c = im2bw(G,graythresh(G));
       figure;
       imshow(c); title('binary image after threshold');
       %c = edge(c);
       %pind=(-1)*romax;
       %oind=-90;
       %figure;
       %imshow(c); title('edge image');
       
       [row,col] = size(c);
       romax = ceil(sqrt(row*row+col*col));
       H = zeros(2*romax+1,180);
       
     
      roind = -romax:romax;
      thetaind = -90:89;
      
%       for R=1:row
%           for C=1:col
%               if c(R,C)==1
%                   for theta=-90:89
%                   %theta=round(atan(Iy(R,C)/Ix(R,C)));
%                   ro = round((R*cos(theta*pi/180)) + (C*sin(theta*pi/180)));
%                   roi=find(roind==ro);
%                   thetai=find(thetaind==theta);
%                   H(roi,thetai) = H(roi,thetai) + 1;
%                   end
%               end
%           end
%       end
        for R=1:row
           for C=1:col
               if c(R,C)==1
                   theta=round(atan(Iy(R,C)/Ix(R,C))*180/pi);
                   ro = round((R*cos(theta*pi/180)) + (C*sin(theta*pi/180)));
                   roi=find(roind==ro);
                   thetai=find(thetaind==theta);
                   H(roi,thetai) = H(roi,thetai) + 1;
               end
           end
       end
       
       
       
       %peak=houghpeaks(A,16);
       %figure;
       %imshow(peak); title('Hough Peak');
       
       %figure;
       %imshow(imadjust(mat2gray(A)), 'XData', T, 'YData', R, 'InitialMagnification' , 'fit'); 
       
%%show hough transform
       peak=houghpeaks(H,20,'threshold',ceil(0.3*max(H(:))));
       figure;
       subplot(1,2,1);
       imagesc(thetaind,roind,H);title('Hough transform');%colormap('jet');
       hold on;
       plot(thetaind(peak(:,2)),roind(peak(:,1)),'s','color','red');
       
       
       lines = houghlines(c,thetaind,roind,peak,'FillGap',7,'MinLength',20);
%       lines = houghlines(c,thetaind,roind,peak,'FillGap',7,'MinLength',1);
       figure, imshow(input_img), hold on
       for k=1:length(lines)
           xy = [lines(k).point1; lines(k).point2];
           plot(xy(:,1),xy(:,2),'LineWidth',5,'Color','green');
           
           
           
           plot(xy(1,1),xy(1,2),'x','LineWidth',1,'Color','Yellow');
           plot(xy(2,1),xy(2,2),'x','LineWidth',1,'Color','red');
           
       end
       title('houghlines');
       
       
       %figure, imshow(input_img), hold on
       
       
       %figure, imshow(input_img), hold on
       %hImg = imshow(lines); title('houghlines'); set(hImg, 'AlphaData', 0.7);% colormap(jet);

end

