%%% This code shows how our 362 Project 1 group created the ideal slanted path for the 
%%% particle by rotating a planar circle with a standard rotation matrix

rprime = zeros(3,59); %initialize

Rnew = Xmatrix(-44.2625); %Xmatrix returns the rotation matrix about the x-axis for the given input angle in degrees

for i = 1:360 %each degree around the circle
    
   ry = 6.75*cosd(i); %creates a circle with radius of 6.75 in the y-z plane
   rz = 6.75*sind(i);
   rx = 0; %centroid
   r_val(:,i) = [rz;rx;ry];
   
   rprime(:,i) = Rnew*r_val(:,i); %rotates the planar circle to a slanted circle with rotation matrix Rnew above
    
end

function R1 = Xmatrix(theta_1)

if isnumeric(theta_1) %converts to radians if it is a number, otherwise it 
                        % leaves it as symbolic (degree trig functions 
                        % can't handle symbolic variables)
                        
    theta_1 = theta_1*pi/180; %convert to radians
    
end

R1 = [1, 0, 0;...
    0, cos(theta_1), sin(theta_1);...
    0, -sin(theta_1), cos(theta_1)]; %Rotation matrix about the x axis

end