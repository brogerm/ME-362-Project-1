% Find the difference between the ideal r and the computed r
r = 6.75;

%% 1 camera error
dx1 = x - center3D(1);
dy1 = y - center3D(2);
r1 = sqrt(dx1.^2 + dy1.^2);

r1_error = abs(r - r1);

% vertical line at y = 0
stepSize = max(r1_error)/(length(x)-1);
y01 = zeros(length(x))';
x01 = (0:stepSize:max(r1_error));

figure(3)
hold on
plot(y, r1_error, 'o');
plot(y01, x01, '--black');
plot(y01 + 6, x01, '--black');


%% 2 camera error
dx2 = a_xyz(1,:) - center3D(1);
dy2 = a_xyz(2,:) - center3D(2);
dz2 = a_xyz(3,:) - center3D(3);
r2 = sqrt(dx2.^2 + dy2.^2 + dz2.^2);

r2_error = abs(r - r2);

% vertical line at y = 0
stepSize = max(r2_error)/(length(a_xyz(1,:)) - 1);
y02 = zeros(length(a_xyz(1,:)))';
x02 = (0:stepSize:max(r2_error));

figure(4)
hold on
plot(a_xyz(2,:), r2_error, 'o');
plot(y02, x02, '--black');
plot(y02 + 6, x02, '--black');



