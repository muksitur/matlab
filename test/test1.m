
function [ output_args ] = Untitled2()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%gray = rgb2gray(img);

%converting into 30x30 pixels
%gray = imresize(gray,[30 30]);

%figure;
%imshow(gray); title('blah blah');

%converting into 32 different intensities
%gray = floor(gray/8);

%disp(gray);

%dlmwrite('myFile.txt',gray);

rx = zeros(1,40000,'uint32');


%x = uint16(0);
%y = uint16(0);

%disp(dec2bin(rx(1,152)));

File = textread('dumm.txt');
[m,n] = size(File);
disp(File);
%index is number of logical points
index=1;
lines=0;
%for i = 1:m
%    if (File(i,2)>=50)
%        temp = temp + 1;
%    end
%end
%Matrix = zeros(temp, 3);

for j = 1:m
        x = floor(File(j,1)*3);
        y = floor(File(j,2)*3);
        %converting RGB into gray
        gray = 0.2989*File(j,3) + 0.5870*File(j,4) + 0.1140*File(j,5);
        % bright = 0, when electron beam off. bright = 1, when electron
        % beam on. if beamer is on and moved, we get a line.
        bright = 0;
        lines = lines + 1;
        % each logical point = (bright<24) | (x<12) | y
        dumor = bitor(bitshift(uint32(bright),24),bitshift(uint32(x),12));
        rx(1,index) = bitor(dumor,uint32(y));
        index = index + 1;
        bright = 1;
        % for each pixel, number of logical points = intensity of the pixel
        for i = 1:floor(gray/4)
            dumor = bitor(bitshift(uint32(bright),24),bitshift(uint32(x),12));
            rx(1,index) = bitor(dumor,uint32(y));
            index = index + 1;
        end
end

disp(lines);
disp(index-1);

fileID = fopen('mug_rand_patternx64inte.txt','w');
formatSpec = '%d,';
for i = 1:index-1
    %disp(rx(1,i));
    %dlmwrite('output.txt',rx(1,i),'delimiter',',');
    fprintf(fileID,formatSpec,rx(1,i));
end
fclose(fileID);

end

