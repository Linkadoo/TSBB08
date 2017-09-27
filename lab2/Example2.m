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
figure(4); colormap gray;
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
figure(2); colormap gray;
subplot (131); imagesc(Im);
subplot(132);  imagesc(rotIm);
subplot(133);  imagesc(nIm);


%Difference image with mask
figure(3); colormap gray;
imagesc(nIm-Im); axis image; axis off; colorbar;
title('difference image of figure 2')

ErrEnergy = sum(sum((nIm-Im).*(nIm-Im)))