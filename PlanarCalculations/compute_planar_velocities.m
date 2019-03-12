plot_3d
dt = 1/30;

%% compute velocity from 2 camera case

% Take the derivative using the central difference method
% neglect velocity in z since it is small and should average out
twoLinVel = [];
for i = 2:(length(twoCamera(1,:)) - 1)
    dx = twoCamera(1,i+1) - twoCamera(1,i-1);
    dy = twoCamera(2,i+1) - twoCamera(2,i-1);
    
    magnitude = sqrt(dx^2 + dy^2);
    
    twoLinVel(i-1) = magnitude/(4*dt);
end

twoAvgLinVel = mean(twoLinVel);
twoAvgAngVel = twoAvgLinVel / r;

%% compute velocity from 1 camera case
oneLinVel = [];
for i = 2:(length(oneCamera(:,1)) - 1)
    dx = oneCamera(i+1,1) - oneCamera(i-1,1);
    dy = oneCamera(i+1,2) - oneCamera(i-1,2);
    
    magnitude = sqrt(dx^2 + dy^2);
    
    oneLinVel(i-1) = magnitude/(4*dt);  
end

oneAvgLinVel = mean(oneLinVel);
oneAvgAngVel = oneAvgLinVel / r;

%% plot the 2 and 1 camera cases
time = (dt:dt:dt*length(twoLinVel));

plotOneAvgLinVel = zeros(length(time)) + oneAvgLinVel;
plotTwoAvgLinVel = zeros(length(time)) + twoAvgLinVel;
trueLinVel = zeros(length(time)) + 2.556 * r;

figure(2)
hold on
title('Computed Linear Velocities')
xlabel('Time (s)')
ylabel('Velocity (in/s)')
plot(time, twoLinVel)
plot(time, oneLinVel)
plot(time, plotTwoAvgLinVel)
plot(time, plotOneAvgLinVel)
plot(time, trueLinVel)
legend({'2 Camera', '1 Camera', '2 Camera Avg', '1 Camera Avg', 'True value'})