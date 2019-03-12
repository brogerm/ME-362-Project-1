
%% compute the x, y, and z coordinates from the 2 cameras
UL = twoCamera(1,:);
VL = twoCamera(2,:);

hold on
for i=1:length(UL) - 68
   plot(UL(i), VL(i), '*black') 
   pause(0.15)
   
end
axis equal