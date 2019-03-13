% plot_slanted_3d
dt = 1/30;

%% compute velocity from 2 camera case

% Take the derivative using the central difference method
twoLinVel = [];
for i = 2:(length(a_xyz(1,:)) - 1)
    dx = twoCamera(1,i+1) - twoCamera(1,i-1);
    dy = twoCamera(2,i+1) - twoCamera(2,i-1);
    dz = twoCamera(3,i+1) - twoCamera(3,i-1);
    
    magnitude = sqrt(dx^2 + dy^2 + dz^2);
    
    twoLinVel(i-1) = magnitude/(4*dt);
end

twoAvgLinVel = mean(twoLinVel);
twoAvgAngVel = twoAvgLinVel ./ r;

%% compute velocity from 1 camera case
oneLinVel = [];
for i = 2:(length(oneCamera(:,1)) - 1)
    dx = oneCamera(i+1,1) - oneCamera(i-1,1);
    dy = oneCamera(i+1,2) - oneCamera(i-1,2);
    dz = oneCamera(i+1,3) - oneCamera(i-1,3);
    
    magnitude = sqrt(dx^2 + dy^2 + dz^2);
    
    oneLinVel(i-1) = magnitude/(4*dt);  
end

oneAvgLinVel = mean(oneLinVel);
oneAvgAngVel = oneAvgLinVel ./ r;

%% plot the 2 and 1 camera cases
time = (dt:dt:dt*length(twoLinVel));

trueVel = 2.556 * r;

timeEndpoints = [min(time) max(time)];

figure(2)
clf
hold on
% title('Computed Linear Velocities')
xlabel('Time (s)')
ylabel('Velocity (in/s)')
plot(time, twoLinVel, 'LineStyle', '--', 'Marker', '*')
plot(time, oneLinVel, 'LineStyle', '--', 'Marker', '*')
plot(timeEndpoints, [twoAvgLinVel twoAvgLinVel])
plot(timeEndpoints, [oneAvgLinVel oneAvgLinVel])
plot(timeEndpoints, [trueVel trueVel])
hold off
legend({'2 Camera', '1 Camera', '2 Camera Avg', '1 Camera Avg', 'True value'})
