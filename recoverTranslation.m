% read the 3 translation images
im1 = imread('data/sl_keyboard/markers_images/keyboard1.jpg');
im2 = imread('data/sl_keyboard/markers_images/keyboard2.jpg');
im3 = imread('data/sl_keyboard/markers_images/keyboard3.jpg');

% load the offset values
load('X_proj_keyboard_1.mat');
load('X_proj_keyboard_2.mat');
load('X_proj_keyboard_3.mat');

% select what translation we want to work with
imL = im1;
imR = im2;
rectL = rect_keyboard_1;
rectR = rect_keyboard_2;
pointsL = X_proj_keyboard_1;
pointsR = X_proj_keyboard_2;

%get a point on the first image
f1 = figure(1);
imshow(imL);
[xL, yL] = getpts(f1);
close;
xL = round(xL);
yL = round(yL);

% get the corresponding point in the second image
f2 = figure(2);
imshow(imR);
[xR, yR] = getpts(f2);
close;
xR = round(xR);
yR = round(yR);

clear f1 f2;

% find the indexes of real-world CS points by offsetting the points
idxL = [xL - rectL(1), yL - rectL(2)];
idxR = [xR - rectR(1), yR - rectR(2)];

% find the real-world CS 3D location for both points and get the
% translation vector from them
posL = pointsL(idxL(1), idxL(2), :);
posR = pointsR(idxR(1), idxR(2), :);
vector = [posL(1) - posR(1), posL(2) - posR(2), posL(3) - posR(3)];

