% Question 5
% [xg ; yg] = [cos(v), sin(v); -sin(v), cos(v)]*[xf;yf]

% Question 6
% g(x,y) = g(round(x),round(y))

Im = double(imread('lab2files/baboon.tif')); % load image
Im = double(imread('logo.tif')); % load image

theta = pi/6;
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

% Question 8
ErrEnergy_spat = sum(sum((nIm-Im).*(nIm-Im)))

%% Question 9
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
fdiff_im = fftshift(fft2(ifftshift(Im-nIm)));
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

%Im = double(imread('lab2files/baboon.tif')); % load image

theta = pi/6;
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

%Im = double(imread('lab2files/baboon.tif')); % load image
theta = pi/6;

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

% Question 27
% Because of the nature of the bicubic function. Say if x_diff = 0.99 ->
% h(x_diff) = 1.5*(~1) - 2.5*(~1 (slightly larger than the first term)) + 1
% < 0

%% Bicubic16 interpolation

Im = double(imread('lab2files/baboon.tif')); % load image
theta = pi/6;

[Ny, Nx] = size(Im);
N = min(min(Nx,Ny));
[x, y] = meshgrid(-ceil((Nx-1)/2):floor((Nx-1)/2), -ceil((Ny-1)/2):floor((Ny-1)/2));
mask = (x.^2 + y.^2)<((N-1)/2)^2;
Im = Im.* mask;
imagesc(Im)
rotIm = rotateimage(Im,theta,'bicubic16');
nIm = rotateimage(rotIm,-theta,'bicubic16');

figure(31); colormap gray;
subplot(131); imagesc (Im, [0 1]); axis image; colorbar;
subplot(132); imagesc (rotIm, [0 1]); axis image; colorbar;
subplot(133); imagesc (nIm,[0 1]); axis image; colorbar;

figure(32); colormap gray;
imagesc(nIm-Im);axis image; axis off; colorbar;

% Question 28
% Less errors around high frequencies (details).
fIm  = fftshift(fft2(ifftshift(Im)));
fnIm = fftshift(fft2(ifftshift(nIm)));
% Question 29
ErrorEnergyBicubic16 = sum(sum((nIm-Im).*(nIm-Im)))
% About 52% of nearest neigbour

figure(34); colormap gray;
relErrorBicubic16 = abs(fIm-fnIm)./abs(fIm);
imagesc(relErrorBicubic16, [0 2])
axis image; colorbar;

%%

%Im = double(imread('lab2files/baboon.tif')); % load image
theta = pi/6.1;

[Ny, Nx] = size(Im);
N = min(min(Nx,Ny));
[x, y] = meshgrid(-ceil((Nx-1)/2):floor((Nx-1)/2), -ceil((Ny-1)/2):floor((Ny-1)/2));
mask = (x.^2 + y.^2)<((N-1)/2)^2;
Im = Im.* mask;

rotImBicub16 = rotateimage(Im,theta,'bicubic16');
rotImBilin = rotateimage(Im,theta,'bilinear');
rotImNN = rotateimage(Im,theta,'nearest');

for i = 1:10
    rotImBicub16 = rotateimage(rotImBicub16,theta,'bicubic16');
    rotImBilin = rotateimage(rotImBilin,theta,'bilinear');
    rotImNN = rotateimage(rotImNN,theta,'nearest');
end

figure(41); colormap gray;
subplot(131); imagesc (rotImNN); axis image; colorbar;
title('RotImNN');
subplot(132); imagesc (rotImBilin); axis image; colorbar;
title('RotImBilinear');
subplot(133); imagesc (rotImBicub16); axis image; colorbar;
title('RotImBicubic16');

% Question 31
% Yes, it is clear that Bicubic16 is the best interpolation method.


%%

%Im = double(imread('baboon.tif'));
[Ny, Nx] = size(Im);
N = min(min(Nx,Ny));
[x,y] = meshgrid(-ceil((Nx-1)/2):floor((Nx-1)/2), ...
-ceil((Ny-1)/2):floor((Ny-1)/2));
mask = (x.^2 + y.^2)<((N-1)/2)^2;
Im = Im.* mask;

[rows, cols] = size(Im);
cx = cols/2;
cy = rows/2;
[X1, Y1] = meshgrid(1:cols, 1:rows); % inimage grid
[X2, Y2] = meshgrid(1:cols, 1:rows); % outimage grid

phi = pi/6;

X1interp = cos(phi)*(X2-cx) - sin(phi)*(Y2-cy) + cx;
Y1interp = sin(phi)*(X2-cx) + cos(phi)*(Y2-cy) + cy;
X1interpback = cos(-phi)*(X2-cx) - sin(-phi)*(Y2-cy) + cx;
Y1interpback = sin(-phi)*(X2-cx) + cos(-phi)*(Y2-cy) + cy;
rotIm = interp2(X1, Y1, Im, X1interp, Y1interp, 'nearest');
backrotIm = interp2(X1, Y1, rotIm, X1interpback, Y1interpback, 'nearest');

figure(51); colormap gray;
subplot(221); imagesc(Im,[0 1]);
axis image; colorbar; title('orig Im')
subplot(222); imagesc(rotIm,[0 1]);
axis image; colorbar; title('rotated Im')
subplot(223); imagesc(backrotIm,[0 1]);
axis image; colorbar; title('backrotated Im')
nansum(nansum((backrotIm-Im).*(backrotIm-Im)))
.
% Question 32,33,34 to go..