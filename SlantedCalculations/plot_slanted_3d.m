%% Load the pixel locations
left_pixel_locations = load('../Left_Slanted_Images/left_slanted_pixel_locations.txt');
right_pixel_locations = load('../Right_Slanted_Images/right_slanted_pixel_locations.txt');
load('L.mat')
load('R.mat')

%% compute the x, y, and z coordinates from the 2 cameras
UL = left_pixel_locations(:,1);
VL = left_pixel_locations(:,2);
UR = right_pixel_locations(:,1);
VR = right_pixel_locations(:,2);
a_xyz = [];


for i=1:length(UL)
    Q = [L(1)-L(9)*UL(i),  L(2)-L(10)*UL(i),  L(3)-L(11)*UL(i);...
     L(5)-L(9)*VL(i),  L(6)-L(10)*VL(i),  L(7)-L(11)*VL(i);...
     R(1)-R(9)*UR(i),  R(2)-R(10)*UR(i),  R(3)-R(11)*UR(i);...
     R(5)-R(9)*VR(i),  R(6)-R(10)*VR(i),  R(7)-R(11)*VR(i)];

    q = [UL(i)-L(4); VL(i)-L(8); UR(i)-R(4); VR(i)-R(8)];

    a_xyz(:,i) = (Q'*Q)^-1*Q'*q; 
end

center3D = [min(a_xyz(1,:)) + (max(a_xyz(1,:)) - min(a_xyz(1,:)))/2, min(a_xyz(2,:)) + (max(a_xyz(2,:)) - min(a_xyz(2,:)))/2, min(a_xyz(3,:)) + (max(a_xyz(3,:)) - min(a_xyz(3,:)))/2];

%% Create the 1 camera case
% determine the pixel locations of the center
c = [min(UL) + (max(UL) - min(UL))/2, min(VL) + (max(VL) - min(VL))/2];
r = 6.75;

% find the scale factor to use
pixelLength = max(UL) - min(UL);
physicalLength = r * 2; % inches
scaleFactor = physicalLength/pixelLength;

% find difference in y pixel height
dy = abs((min(VL) - max(VL)) * scaleFactor);
theta = asin(dy/(2*r));

% convert pixel values to x and y values
x = (UL - c(1)) * scaleFactor + center3D(1);
y = (c(2) - VL) * scaleFactor + center3D(2);
z = center3D(3) - (c(2) - VL) * scaleFactor/tan(theta);

%% create ideal case
slantedPath
x_i = rprime(1,:)' + center3D(1);
y_i = rprime(2,:)' + center3D(2);
z_i = rprime(3,:)' + center3D(3);

%% make plot

twoCamera = a_xyz;
oneCamera = [x, y, z];
ideal = [x_i, y_i, z_i];

figure(1)
hold on
plot3(twoCamera(1,:), twoCamera(3,:), twoCamera(2,:),'-blue');
plot3(oneCamera(:,1), oneCamera(:,3), oneCamera(:,2), '--green')
plot3(ideal(:,1), ideal(:,3), ideal(:,2), '-red')
plot3(center3D(1), center3D(3), center3D(2), '*black');

grid on
axis equal
title('Slanted Rotation Trajectories')
xlabel('x-axis')
ylabel('y-axis')
zlabel('z-axis')
% xlim([5 25]);
% ylim([0 10]);
% zlim([-5 15]);
legend({'2 Camera', '1 Camera', 'Ideal', 'Center of Rotation'})


