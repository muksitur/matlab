function out = lubin( img1, img2)
%% these sites are followed to implement this model: https://books.google.de/books?hl=en&lr=&id=BBfYYFofnP8C&oi=fnd&pg=PA245&dq=visual+discrimination+model&ots=IT5_UTJ6un&sig=M_bfzgNa_2EO3EuFBsUjYvv8fRI#v=onepage&q=visual%20discrimination%20model&f=false
%reading reference and distorted images
clc
close all

img1 = rgb2gray((img1));
img2 = rgb2gray((img2));
%img3 = rgb2gray((img3));

%figure;
%imshow(img3); title('distorted2');
figure;
subplot(1,2,1); imshow(img1); title('original');
subplot(1,2,2); imshow(img2); title('distorted');

%% applying 2D gaussian(one of classic PSF) on the original and distorted images http://chemaguerra.com/point-spread-functions-convolutions/ 
% https://de.mathworks.com/help/images/ref/imgaussfilt.html
%choosing sigma = 2 for bandpass filter
sigma = 2;
psfimg1 = imgaussfilt(img1,sigma);
psfimg2 = imgaussfilt(img2,sigma);
%psfimg3 = imgaussfilt(img3,sigma);

figure;
subplot(1,2,1); imshow(psfimg1); title('original psf');
subplot(1,2,2); imshow(psfimg2); title('distorted psf');


%% choosing one resolution for resampling. scale = 0.85
scale = 0.85;
resampimg1 = imresize(psfimg1,scale);
resampimg2 = imresize(psfimg2,scale);
%resampimg3 = imresize(psfimg3,scale);

figure;
subplot(1,2,1); imshow(resampimg1); title('original resampled');
subplot(1,2,2); imshow(resampimg2); title('distorted resampled');


%% oriented response. applying gabor filter on images. also applying normalization
% https://dsp.stackexchange.com/questions/11467/apply-a-gabor-filter-to-an-input-image

theta=0; %either 0 or pi/4 or pi/2 or 3pi/4
orient(resampimg1, resampimg2, theta);

theta=pi/4; %either 0 or pi/4 or pi/2 or 3pi/4
orient(resampimg1, resampimg2, theta);

theta=pi/2; %either 0 or pi/4 or pi/2 or 3pi/4
orient(resampimg1, resampimg2, theta);

theta=3*pi/4; %either 0 or pi/4 or pi/2 or 3pi/4
orient(resampimg1, resampimg2, theta);

end

%% orientation function
%mag is the convolution of image and gabor filter. normalization is done by taking the difference between decomposed
%signals(mag) of reference and distorted images
function out = orient(img1, img2, theta)
lambda=3.5;
gamma=0.3;
sigma=2.8;
psi=0;

sigma_x = sigma;
sigma_y = sigma/gamma;

nstds = 5;
xmax = max(abs(nstds*sigma_x*cos(theta)),abs(nstds*sigma_y*sin(theta)));
xmax = ceil(max(1,xmax));
ymax = max(abs(nstds*sigma_x*sin(theta)),abs(nstds*sigma_y*cos(theta)));
ymax = ceil(max(1,ymax));
xmin = -xmax; ymin = -ymax;
[x,y] = meshgrid(xmin:xmax,ymin:ymax);

x_theta=x*cos(theta)+y*sin(theta);
y_theta=-x*sin(theta)+y*cos(theta);

gb= exp(-.5*(x_theta.^2/sigma_x^2+y_theta.^2/sigma_y^2)).*cos(2*pi/lambda*x_theta+psi);

figure;
imshow(gb);
title(['theta = ' num2str(theta/pi) 'pi']);
%imagesc(gb);
%colormap(gray);
%title('theta=...');
magimg1 = conv2(double(img1),double(gb));
magimg2 = conv2(double(img2),double(gb));
%magimg3 = conv2(double(img3),double(gb));
normimg = abs(magimg1 - magimg2);
%str1 = sprintf('original oriented ',theta,' degree');
%str2 = sprintf('distorted1 oriented %d degree', theta);
%str3 = sprintf('distorted2 oriented %d degree', theta);

figure;
subplot(1,3,1); imshow(magimg1,[]); title(['original oriented at theta = ' num2str(theta/pi) 'pi']);
subplot(1,3,2); imshow(magimg2,[]); title(['distorted image oriented at theta = ' num2str(theta/pi) 'pi']);
subplot(1,3,3); imshow(normimg,[]); title(['normalized image oriented at theta = ' num2str(theta/pi) 'pi']);

end