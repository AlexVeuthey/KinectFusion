function [ matchesL, matchesR ] = manual_match( imL, imR )
%MANUAL_MATCH Find 3 matching points given the 2 associated images
%   Trivial

matchesL = zeros(2,3);
matchesR = zeros(2,3);

% POINT 1

disp('First point...');

f1 = figure(1);
imshow(imL); [xL, yL] = getpts(f1); close;
matchesL(1,1) = round(xL);
matchesL(2,1) = round(yL);

% get the corresponding point in the second image
f2 = figure(2);
imshow(imR); [xR, yR] = getpts(f2); close;
matchesR(1,1) = round(xR);
matchesR(2,1) = round(yR);

% POINT 2

disp('Second point...');

f1 = figure(1);
imshow(imL); [xL, yL] = getpts(f1); close;
matchesL(1,2) = round(xL);
matchesL(2,2) = round(yL);

% get the corresponding point in the second image
f2 = figure(2);
imshow(imR); [xR, yR] = getpts(f2); close;
matchesR(1,2) = round(xR);
matchesR(2,2) = round(yR);

% POINT 3

disp('Third point...');

f1 = figure(1);
imshow(imL); [xL, yL] = getpts(f1); close;
matchesL(1,3) = round(xL);
matchesL(2,3) = round(yL);

% get the corresponding point in the second image
f2 = figure(2);
imshow(imR); [xR, yR] = getpts(f2); close;
matchesR(1,3) = round(xR);
matchesR(2,3) = round(yR);

end
