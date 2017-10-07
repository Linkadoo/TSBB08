Im = double(imread('lab2files/baboon.tif')); % load image

theta = pi/3;
rotIm = rotateimage(Im, theta,'nearest');
nIm = rotateimage(rotIm, -theta, 'nearest');

%Rotation without circular mask

figure(1); colormap gray;
subplot (131); imagesc(Im);
subplot(132);  imagesc(rotIm);
subplot(133);  imagesc(nIm);

%Difference image without mask
figure(2); colormap gray;
imagesc(nIm-Im); axis image; axis off; colorbar;
title('difference image of figure 1')

%Mask
[Ny, Nx] = size(Im);
N = min(min(Nx,Ny));
[x,y] = meshgrid(-ceil((Nx-1)/2):floor((Nx-1)/2), ...
-ceil((Ny-1)/2):floor((Ny-1)/2));
mask = (x.^2 + y.^2)<((N-1)/2)^2;
Im = Im.* mask;

rotIm = rotateimage(Im, theta,'nearest');
nIm = rotateimage(rotIm, -theta, 'nearest');

%Rotation with mask
figure(3); colormap gray;
subplot (131); imagesc(Im);
subplot(132);  imagesc(rotIm);
subplot(133);  imagesc(nIm);


%Difference image with mask
figure(4); colormap gray;
imagesc(nIm-Im); axis image; axis off; colorbar;
title('difference image of figure 2')

% Question 7
% The difference image is as large the original image. The interpolation
% errors are distributed throughout the image.

%% Question 8
ErrEnergy_spat = sum(sum((nIm-Im).*(nIm-Im)))

% Question 9
% Because log(0) is undefined.

fIm = fftshift(fft2(ifftshift(Im)));
frotIm = fftshift(fft2(ifftshift(rotIm)));
fnIm = fftshift(fft2(ifftshift(nIm)));

figure(5); colormap gray;
subplot(221); imagesc(log10(abs(fIm))+1)
title('fIm'); axis image; colorbar;

subplot(222); colormap gray;
imagesc(log10(abs(frotIm)+1))
title('frotIm'); axis image;colorbar;

subplot(223); imagesc(log10(abs(fnIm)+1))
title('fnIm'); axis image; colorbar;

% Question 10
% Yes, they have similar traits.

% Question 11

figure(6); colormap gray;
fdiff_four = fIm - fnIm;
fdiff_im = fftshift(fft2(ifftshift(fIm-fnIm)));
subplot(121); imagesc(log10(abs(fdiff_four)+1));
subplot(122); imagesc(log10(abs(fdiff_im)+1));

% Why are they different?
abs(fIm-fnIm)./abs(fIm);
N = size(fIm);
ErrEnergy_four = sum(sum((fIm-fnIm).*conj(fIm-fnIm)))/(N(1)*N(2))

% Question 12
% Same as for the spatial domain.

% Question 13
% Parseval's theorem

% Question 14
% Yes.

% Question 15
ErrEnergy_rel = sum(sum(abs(fIm-fnIm)))/sum(sum(abs(fnIm)))
% Small changes. Why can it be better? Seems like the sizes of each
% frequency is correct, but they point in different directions.

% Question 16
figure(7); colormap gray;
relError = abs(fIm-fnIm)./abs(fIm);
imagesc(relError, [0 2])
axis image; colorbar;
% The large errors are for high frequencies (details).

%% 3 Bilinear interpolation

Im = double(imread('lab2files/baboon.tif')); % load image

theta = pi/3;
%Mask
[Ny, Nx] = size(Im);
N = min(min(Nx,Ny));
[x,y] = meshgrid(-ceil((Nx-1)/2):floor((Nx-1)/2), ...
-ceil((Ny-1)/2):floor((Ny-1)/2));
mask = (x.^2 + y.^2)<((N-1)/2)^2;
Im = Im.* mask;

rotIm = rotateimage(Im, theta,'bilinear');
nIm = rotateimage(rotIm, -theta, 'bilinear');
%Rotation without circular mask

figure(11); colormap gray;
subplot (131); imagesc(Im);
subplot(132);  imagesc(rotIm);
subplot(133);  imagesc(nIm);

% Question 17
% 

figure(12); colormap gray;
imagesc(nIm-Im); axis image; axis off; colorbar;
title('difference image of figure 1')

% Question 18
% The image is a smoothed variant. There are only small differences,
% although many, compared to the original image.

% Question 19
% About 88% of nearest neigbour
ErrorEnergyBilinear = sum(sum((nIm-Im).*(nIm-Im)))

% Question 20
% Because we smooth with the rotation.

fIm  = fftshift(fft2(ifftshift(Im)));
fnIm = fftshift(fft2(ifftshift(nIm)));

figure(13); colormap gray;
subplot(131); imagesc(log10(abs(fIm)+1)); axis image; colorbar;
subplot(132); imagesc(log10(abs(fnIm)+1)); axis image; colorbar;

% Question 21
% Because we didn't smooth.

figure(14); colormap gray;
relError = abs(fIm-fnIm)./abs(fIm);
imagesc(relError, [0 2])
axis image; colorbar;

%% Bicubic interpolation

Im = double(imread('lab2files/baboon.tif')); % load image
theta = pi/3;

[Ny, Nx] = size(Im);
N = min(min(Nx,Ny));
[x, y] = meshgrid(-ceil((Nx-1)/2):floor((Nx-1)/2), -ceil((Ny-1)/2):floor((Ny-1)/2));
mask = (x.^2 + y.^2)<((N-1)/2)^2;
Im = Im.* mask;

rotIm = rotateimage(Im,theta,'bicubic');
nIm = rotateimage(rotIm,-theta,'bicubic');

figure(21); colormap gray;
subplot(131); imagesc (Im); axis image; colorbar;
subplot(132); imagesc (rotIm); axis image; colorbar;
subplot(133); imagesc (nIm); axis image; colorbar;

figure(22); colormap gray;
imagesc(nIm-Im);axis image; axis off; colorbar;


% Question 23
% function goes here

% Question 24
% Looks similar to bilinear interpolation

% Question 25
ErrorEnergyBicubic = sum(sum((nIm-Im).*(nIm-Im)))
% About 72% of nearest neigbour

fIm  = fftshift(fft2(ifftshift(Im)));
fnIm = fftshift(fft2(ifftshift(nIm)));

figure(13); colormap gray;
subplot(131); imagesc(log10(abs(fIm)+1)); axis image; colorbar;
subplot(132); imagesc(log10(abs(fnIm)+1)); axis image; colorbar;

figure(24); colormap gray;
relError = abs(fIm-fnIm)./abs(fIm);
imagesc(relError, [0 2])
axis image; colorbar;

% Question 26
% Seems like more high frequencies, but it has a lower total error.

%% Bicubic16 interpolation

Im = double(imread('lab2files/baboon.tif')); % load image
theta = pi/3;

[Ny, Nx] = size(Im);
N = min(min(Nx,Ny));
[x, y] = meshgrid(-ceil((Nx-1)/2):floor((Nx-1)/2), -ceil((Ny-1)/2):floor((Ny-1)/2));
mask = (x.^2 + y.^2)<((N-1)/2)^2;
Im = Im.* mask;

rotIm = rotateimage(Im,theta,'bicubic16');
nIm = rotateimage(rotIm,-theta,'bicubic16');

figure(31); colormap gray;
subplot(131); imagesc (Im); axis image; colorbar;
subplot(132); imagesc (rotIm); axis image; colorbar;
subplot(133); imagesc (nIm); axis image; colorbar;

figure(32); colormap gray;
imagesc(nIm-Im);axis image; axis off; colorbar;
