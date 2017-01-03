
% setup the devices for color and depth
% colorDevice = imaq.VideoDevice('kinect',1);
depthDevice = imaq.VideoDevice('kinect',2);

% release(colorDevice);
% release(depthDevice);

% initialize them
% step(colorDevice);

step(depthDevice);

% load one frame
% colorImage = step(colorDevice);
depthImage = step(depthDevice);

% create a point cloud from the data
ptCloud = pcfromkinect(depthDevice,depthImage);

% xlimits = [0 1];
% ylimits = [0 1];
% zlimits = [0 1];

nFrames = 10;

% plot the frame captured
% player = pcplayer(xlimits, ylimits, zlimits);

player = pcplayer(ptCloud.XLimits,ptCloud.YLimits,ptCloud.ZLimits,...
	'VerticalAxis','y','VerticalAxisDir','down');

xlabel(player.Axes,'X (m)');
ylabel(player.Axes,'Y (m)');
zlabel(player.Axes,'Z (m)');

% acquire n frames
for i = 1:nFrames
%    colorImage = step(colorDevice);  
   depthImage = step(depthDevice);
 
   ptCloud = pcfromkinect(depthDevice,depthImage);
   
   str = strcat('kinect', num2str(i));
   
   pcwrite(ptCloud, str, 'PLYFormat', 'binary');
 
   view(player,ptCloud);
end

% release the objects
% release(colorDevice);
release(depthDevice);
