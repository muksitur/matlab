function [ output_args ] = Untitled()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

file = textread('test3.txt');
%[m,n] = size(file);
%s = spectrogram(file);


disp(file);

%g = dgt(file, 'gauss', 10,40);
g = gabor(file,pi/2);
%magimg = conv2(double(file),double(g));
figure;
imagesc(log(abs(g))); title('gabor spectrogram'); ylabel('Frequency(Hz)'); xlabel('Time(Seconds)');

figure;
imagesc(log(abs(fftshift(fft(file))))); title('fft spectrogram'); ylabel('Frequency(Hz)'); xlabel('Time(Seconds)');
%imshow(s); tilte('fft spectrogram');
%imagesc(log(abs(fftshift(fft2(input_img))))); title('original spectra');
%imagesc(log(abs(fftshift(fft(file))))); title('fft spectrogram'); ylabel('Frequency(Hz)'); xlabel('Time(Seconds)');

%imagesc(log(abs(fftshift(g)))); title('gabor spectrogram');

end

