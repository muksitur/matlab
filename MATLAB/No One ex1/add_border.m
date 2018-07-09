function [ output_args ] = Untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

a = rgb2gray(input_args);

%[nrows,ncols] = size(a);

b = padarray(a,[10 10]);

output_args = b;

end

