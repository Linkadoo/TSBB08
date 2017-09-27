%% TSBB08 - Lab 2
Im = double(imread('lab2files/baboon.tif')); % load image

%% Question 1-4
run('Example1.m')

%% Question 5
% [xg ; yg] = [cos(v), sin(v); sin(v), cos(v)]*[xf;yf]

%% Question 6
% g(x,y) = g(round(x),round(y))

run('Example2.m')

% Question 7
% The difference image is as large the original image. The interpolation
% errors are distributed throughout the image.

% Question 9
% Because log(0) is undefined.