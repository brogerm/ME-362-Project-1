%% Load the pixel locations
left_pixel_locations = load('../Left_Planar_Images/left_planar_pixel_locations.txt');
right_pixel_locations = load('../Right_Planar_Images/right_planar_pixel_locations.txt');
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

%% create ideal case
theta = (0:pi/16:2 * pi);
r = 6.75;
x_i = (r * cos(theta) + center3D(1))';
y_i = (r * sin(theta) + center3D(2))';
z_i = (zeros(length(x_i)) + 6)';

%% Create the 1 camera case
% determine the pixel locations of the center
c = [min(UL) + (max(UL) - min(UL))/2, min(VL) + (max(VL) - min(VL))/2];

% find the scale factor to use
pixelLength = max(UL) - min(UL);
physicalLength = r * 2; % inches
scaleFactor = physicalLength/pixelLength;

% convert pixel values to x and y values
x = (UL - c(1)) * scaleFactor + center3D(1);
y = (c(2) - VL) * scaleFactor + center3D(2);
z = zeros(length(x)) + center3D(3);



%% make plot

twoCamera = a_xyz;
oneCamera = [x, y, z];
ideal = [x_i, y_i, z_i];

figure(1)
clf
ax = axes;
ax.Camera
hold on
plot3(twoCamera(1,:), twoCamera(3,:), twoCamera(2,:), 'Color', 'blue', 'LineStyle', 'none', 'Marker', '.', 'MarkerSize',20);
plot3(oneCamera(:,1), oneCamera(:,3), oneCamera(:,2), 'Color', [0, 0.760, 0.541], 'LineStyle', 'none', 'Marker', '.', 'MarkerSize',20)
plot3(ideal(:,1), ideal(:,3), ideal(:,2), '-red', 'LineWidth',2)
plot3(center3D(1), center3D(3), center3D(2), '*black');

grid on
axis equal
% title('Slanted Rotation Trajectories')
xlabel('X (in)')
ylabel('Y (in)')
zlabel('Z (in)')
xlim([5 25]);
ylim([0 10]);
zlim([-5 15]);
hold off
legend({'2 Camera', '1 Camera', 'Ideal', 'Center of Rotation'})
view(ax, 100, 10)


