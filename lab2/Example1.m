T1 = [1 -1/3; 0 1]; % assign shear matrix1
T2 = [1 -1; 0 1]; % assign shear matrix2

figure(1); colormap gray;
shearIm1 = shearimage(Im,T1);
shearIm2 = shearimage(Im,T2);
subplot(221); imagesc(Im); axis image; colorbar;
subplot(222); imagesc(shearIm1); axis image; colorbar;
subplot(224); imagesc(shearIm2); axis image; colorbar;

% Question 1
% Since (X1) = T(X2) if you want to change in which coordinates you express
% something you take the inverse: T^-1(X1) = T^-1 T(X2) = X2

% Question 2
% The whole top line is transformed on itself so I don't know if there is a
% a particular point that it's sheared on.

% Question 3
%     xyff = inv(T)*[xg + T(1,2)* cols/2;
%                    yg + T(2,1)* rows/2];

%% Time comparsion
T = [1 -1/3; 0 1]; % assign shear matrix

slow = tic;
shearImSlow = shearimage(Im,T);
slow = toc(slow)
fast = tic;
shearImFast = shearimageFast(Im,T);
fast = toc(fast)

% Question 4
% Yes, the fast transformation is about 100 times faster, compared to the
% slow.