function [ magimg ] = gabor( input, theta )
%theta is the orientation here
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
lambda=3.5; %this is wavelength
gamma=0.35;
sigma=1;
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

%figure;
%imshow(gb);
%title(['theta = ' num2str(theta/pi) 'pi']);
%imagesc(gb);
%colormap(gray);
%title('theta=...');
magimg = conv2(double(input),double(gb));

end

