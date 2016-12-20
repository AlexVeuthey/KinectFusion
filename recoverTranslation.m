imL = imread('data/sl_keyboard/markers_images/keyboard1.jpg');
imR = imread('data/sl_keyboard/markers_images/keyboard2.jpg');

f1 = figure(1);
imshow(imL);
[xL, yL] = getpts(f1);
close;

f2 = figure(2);
imshow(imR);
[xR, yR] = getpts(f2);
close;

vector = [xR-xL, yR-xL];