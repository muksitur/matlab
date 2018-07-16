function [ output_args ] = Untitled()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

file = textread('test1.txt');
%[m,n] = size(file);
%s = spectrogram(file);

figure;
plot(file); title('original data');

fastft = fft(file);
figure;
plot(fastft); title('fft data');

y = [1 -1];
x = [0 8000];

%g = dgt(file, 'gauss', 10,40);

% gabor() is my own function. i implemented this in some earlier project. 
%g = gabor(file,pi/2);
gab = sgram(file(:));
sgramfft = sgram(fastft(:));
%magimg = conv2(double(file),double(g));

%figure;
%imagesc(x,y,file); title('original data spectrogram'); ylabel('Frequency(Hz)'); xlabel('Time(Seconds)');

figure;
%imagesc(x,y,log(abs(g))); title('gabor spectrogram'); ylabel('Frequency(Hz)'); xlabel('Time(Seconds)');
imagesc(x,y,gab); title('gabor spectrogram'); ylabel('Frequency(Normalized)'); xlabel('Time(Seconds)');

figure;
imagesc(x,y,sgramfft); title('fft spectrogram'); ylabel('Frequency(Normalized)'); xlabel('Time(Samples)');
%imshow(s); tilte('fft spectrogram');
%imagesc(log(abs(fftshift(fft2(input_img))))); title('original spectra');
%imagesc(log(abs(fftshift(fft(file))))); title('fft spectrogram'); ylabel('Frequency(Hz)'); xlabel('Time(Seconds)');

%imagesc(log(abs(fftshift(g)))); title('gabor spectrogram');

end

