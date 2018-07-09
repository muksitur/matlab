function [ output_args ] = Untitled(a,Ix,Iy)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



[row,col] = size(Ix);

for R = 3:row-2
    for C = 3:col-2
        sumIx = 0;
        sumIy = 0;
        sumIxIy = 0;

        for wr = R-2:R+2
            for wc = C-2:C+2
                sumIx = sumIx + Ix(wr,wc)*Ix(wr,wc);
                sumIy = sumIy + Iy(wr,wc)*Iy(wr,wc);
                sumIxIy = sumIxIy + Ix(wr,wc).*Iy(wr,wc);
                %disp(x(wr,wc));
            end
        end
        %sumIx = sumIx./25;
        %sumIy = sumIy./25;
        %sumIxIy = sumIxIy./25;
        
        M = [sumIx,sumIxIy ; sumIxIy,sumIy];
        
        if ((trace(M)/2) - sqrt((trace(M)/2)^2 - det(M))) > 0
            w(R,C) = (trace(M)/2) - sqrt((trace(M)/2)^2 - det(M));
        else
            w(R,C) = 0;
        end
        
        if (4*det(M)/(trace(M)^2)) >= 0 & (4*det(M)/(trace(M)^2)) <= 1
            q(R,C) = 4*det(M)/(trace(M)^2);
        else
            q(R,C) = 0;
        end
        
        if w(R,C) > 0.004 & q(R,C) > 0.5
            Mc(R,C) = 1;
        else
            Mc(R,C) = 0;
        end
        %qmask(R,C) = q(R,C).*Mc(R,C);
        %wmask(R,C) = w(R,C).*Mc(R,C);
        %qw(R,C) = qmask(R,C).*wmask(R,C);
        %regionmax(R,C) = imregionalmax(qw);
        %W(R,C) = sum(diag(M))./2 - sqrt((sum(diag(M)))./2).^2 - det(M(R,C)); 
    end
end

qmask = q.*Mc;
wmask = w.*Mc;
qw = qmask.*wmask;

regionmax = imregionalmax(qw);
%for R = 3:row-2
%    for C = 13:col-2
%        new(R,C) = a(R,C) + regionmax(R,C);
%    end
%end

%f = find(qw);

%new = a + regionmax;

figure;
imshow(w); title('Cornerness W'); colormap(jet);

%the roundness result looks different. we have no explation why.
figure;
imshow(q); title('Roundness Q'); colormap(jet);

figure;
imshow(qmask); title('Threshold region of Q'); colormap(jet);

figure;
imshow(wmask); title('Threshold region of W'); colormap(jet);

figure;
imshow(regionmax); title('point of interest');% colormap(jet);

%figure;
%imshow(new); title('point of interest on image'); colormap(jet);


%here we plotted the points of interest on the input image. we were having trouble in using find() and plot(). 
%that's why we did it differently. we hope the result looks as expected. 

figure, imshow(a), hold on
hImg = imshow(regionmax); title('point of interest on image'); set(hImg, 'AlphaData', 0.1);% colormap(jet);

end

