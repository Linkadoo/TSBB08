addpath('/site/edu/bb/mips/7.0');
mips;
%% Simple image manipulation
Im = double(imread('baboon.tif')); % load image

[rows, cols] = size(Im); 
fIm = fftshift(fft2(fftshift(Im)) / (rows * cols)); 

% Question 1:
% The image will be the original picture again.

% Question 2:
% Black = 0, White = 255;
% Like in previous labs with the command "colormap gray;" this will map a
% value between 0-255 to a corresponding color.

% Question 3:
% -6.6 .0.78i
% All values above a certain threshold seems to be truncated to white.
% Although.. One black pixel has the value 0.46+0.48i and a white has
% -0.042-0.025i... I dont know how this works...

% Question 4
% The clic image has a lot more brighter pixels (the historgram is
% displaced more to the right), while the blod256 is mroe the the left.

% Question 5
% Most pixels are centered.

% Copy the image baboon to the MATLAB matrix f:
f = getactive;
B = 255/3;
A =255/150;

g = A * f- B;
% Copy the MATLAB matrix g to the image monkey:
newimage (g, 'monkey', 2);

% Question 6
% Since f=50 -> g=0 gives 0 = 50A - B and f=200 -> g=255 
% gives 255 = 200A - B which, when solved gives A= 255/150, B =255/3.

% Question 7
% It now uses the full greyscale spectra.


%% Binary operations

% Question 8:
% Dilation is an operation that "fills in" an image. Say an image is all
% black except for one pixel which is white. Then a dilation of that image 
% could be to set all neighbouring pixels to that one white pixel to also 
% be white. 

% Erosion is the opposite of that. It "hollows" the picture.

% d(4)
% 0 1 0
% 1 X 1
% 0 1 0

% d(8)
% 1 1 1
% 1 X 1
% 1 1 1

% octagonal
% 0 1 1 1 0
% 1 1 1 1 1
% 1 1 X 1 1
% 1 1 1 1 1
% 0 1 1 1 0

% Question 10:
% Dilation -> Erosion
% Erosion -> Dilation

% Question 11:
% Using threshold 135. You can get the threshold from the histogram by
% looking at the different bumps.

