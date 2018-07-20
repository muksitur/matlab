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

File = textread('dumm.txt');

disp(File);

[m,n] = size(File);
index=1;
temp=0;
%for i = 1:m
%    if (File(i,2)>=50)
%        temp = temp + 1;
%    end
%end
%Matrix = zeros(temp, 3);

for j = 1:m
        x = File(j,1)*10;
        y = File(j,2)*10;
        gray = File(j,3);
        bright = 0;
        
        dumor = bitor(bitshift(bright,24),bitshift(x,12));
        rx(1,index) = bitor(dumor,y);
        index = index + 1;
        bright = 1;
        
        for i = 1:floor(gray/8)
            dumor = bitor(bitshift(bright,24),bitshift(x,12));
            rx(1,index) = bitor(dumor,y);
            index = index + 1;
        end
end

fileID = fopen('output.txt','w');
formatSpec = '%d,\n';
for i = 1:index-1
    disp(rx(1,i));
    %dlmwrite('output.txt',rx(1,i),'delimiter',',');
    fprintf(fileID,formatSpec,rx(1,i));
end
fclose(fileID);

end

