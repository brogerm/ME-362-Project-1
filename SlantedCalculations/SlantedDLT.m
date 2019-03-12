%% Read in the images you want to do a dlt on
% cd('/Users/Tadd/Documents/0_Current Projects/Courses/BYU 363 Fall2010/Quizes')
IL = imread('../Left_Slanted_Images/000001.jpg');
IR = imread('../Right_Slanted_Images/000001.jpg');

% You must know the actual location of the six points in space before you
% begin so insert them here.
x = [0 0 13.4 24 24 24 0 0];
y = [0 0 7.5  0  0  6  6 6];
z = [0 6 2.75 6  0  0  0 6];
xyz = [x;y;z];
fsize = 18;
msize = 10;

%% Get the 7 points of interest 
figure(1),clf
imshow(IL)
%This is to move the figure title
pos = get(gca, 'Position');
yoffset = -0.1;
pos(2) = pos(2) + yoffset;
set(gca, 'Position', pos)

%Select data points from image
title({'Left image: Pick 7 points of interest';'corresponding to the points in x,y,z';'Use the right mouse button to select, and the left one to zoom'})
[uL,vL] = ginput2(8);
hold on
plot(uL,vL,'rs','MarkerFaceColor','r','MarkerSize',msize)
text(uL(1),vL(1),'1','FontSize',fsize,'FontWeight','bold','Color','w')
text(uL(2),vL(2),'2','FontSize',fsize,'FontWeight','bold','Color','w')
text(uL(3),vL(3),'3','FontSize',fsize,'FontWeight','bold','Color','w')
text(uL(4),vL(4),'4','FontSize',fsize,'FontWeight','bold','Color','w')
text(uL(5),vL(5),'5','FontSize',fsize,'FontWeight','bold','Color','w')
text(uL(6),vL(6),'6','FontSize',fsize,'FontWeight','bold','Color','w')
text(uL(7),vL(7),'7','FontSize',fsize,'FontWeight','bold','Color','w')
text(uL(8),vL(8),'8','FontSize',fsize,'FontWeight','bold','Color','w')

figure(2),clf
imshow(IR)
%This is to move the figure title
pos = get(gca, 'Position');
yoffset = -0.1;
pos(2) = pos(2) + yoffset;
set(gca, 'Position', pos)
title({'Right image: Pick 7 points of interest';'corresponding to the points in x,y,z';'Use the right mouse button to select, and the left one to zoom'})
%Select data points from image
[uR,vR] = ginput2(8);
hold on
plot(uR,vR,'rs','MarkerFaceColor','r','MarkerSize',msize)
text(uR(1),vR(1),'1','FontSize',fsize,'FontWeight','bold','Color','w')
text(uR(2),vR(2),'2','FontSize',fsize,'FontWeight','bold','Color','w')
text(uR(3),vR(3),'3','FontSize',fsize,'FontWeight','bold','Color','w')
text(uR(4),vR(4),'4','FontSize',fsize,'FontWeight','bold','Color','w')
text(uR(5),vR(5),'5','FontSize',fsize,'FontWeight','bold','Color','w')
text(uR(6),vR(6),'6','FontSize',fsize,'FontWeight','bold','Color','w')
text(uR(7),vR(7),'7','FontSize',fsize,'FontWeight','bold','Color','w')
text(uR(8),vR(8),'8','FontSize',fsize,'FontWeight','bold','Color','w')

%% Determine the L matrix

% Make the parts of the FL matrix
tu = repmat([1 0 0 0 0],8,1);
tv = repmat([0 0 0 0],8,1);
tv2 = repmat([1],8,1);
XL = horzcat(xyz',tu,[-uL.*xyz(1,:)'],[-uL.*xyz(2,:)'],[-uL.*xyz(3,:)']);
YL = horzcat(tv,xyz',tv2,[-vL.*xyz(1,:)'],[-vL.*xyz(2,:)'],[-vL.*xyz(3,:)']);

XR = horzcat(xyz',tu,[-uR.*xyz(1,:)'],[-uR.*xyz(2,:)'],[-uR.*xyz(3,:)']);
YR = horzcat(tv,xyz',tv2,[-vR.*xyz(1,:)'],[-vR.*xyz(2,:)'],[-vR.*xyz(3,:)']);


FL = vertcat(XL(1,:),YL(1,:));  
gL = vertcat(uL(1,:),vL(1,:));
FR = vertcat(XR(1,:),YR(1,:));  
gR = vertcat(uR(1,:),vR(1,:));
for i = 2:length(uL)
    gL = vertcat(gL,uL(i),vL(i));  % Fill in the gL matrix
    FL = vertcat(FL,XL(i,:),YL(i,:));% Fill in the FL matrix
    gR = vertcat(gR,uR(i),vR(i));  % Fill in the gR matrix
    FR = vertcat(FR,XR(i,:),YR(i,:));% Fill in the FR matrix
end

% Matrix manipulation using the Morse-Penrose pseudo-inverse method
L = (FL'*FL)^-1*FL'*gL;
R = (FR'*FR)^-1*FR'*gR;


%%  Now find another point on the block.
pause

figure(1),clf
imshow(IL)
title('Pick a point you want to know the distance from origin to')
hold on
plot(uL,vL,'rs','MarkerFaceColor','r','MarkerSize',msize)
text(uL(1),vL(1),'1','FontSize',fsize,'FontWeight','bold','Color','w')
text(uL(2),vL(2),'2','FontSize',fsize,'FontWeight','bold','Color','w')
text(uL(3),vL(3),'3','FontSize',fsize,'FontWeight','bold','Color','w')
text(uL(4),vL(4),'4','FontSize',fsize,'FontWeight','bold','Color','w')
text(uL(5),vL(5),'5','FontSize',fsize,'FontWeight','bold','Color','w')
text(uL(6),vL(6),'6','FontSize',fsize,'FontWeight','bold','Color','w')
text(uL(7),vL(7),'7','FontSize',fsize,'FontWeight','bold','Color','w')
text(uL(8),vL(8),'8','FontSize',fsize,'FontWeight','bold','Color','w')
[UL,VL] = ginput2(1);
plot(UL,VL,'bo','MarkerFaceColor','b','MarkerSize',msize)


figure(2),clf
imshow(IR)
title('Pick a point you want to know the distance from origin to')
hold on
plot(uR,vR,'rs','MarkerFaceColor','r','MarkerSize',msize)
text(uR(1),vR(1),'1','FontSize',fsize,'FontWeight','bold','Color','w')
text(uR(2),vR(2),'2','FontSize',fsize,'FontWeight','bold','Color','w')
text(uR(3),vR(3),'3','FontSize',fsize,'FontWeight','bold','Color','w')
text(uR(4),vR(4),'4','FontSize',fsize,'FontWeight','bold','Color','w')
text(uR(5),vR(5),'5','FontSize',fsize,'FontWeight','bold','Color','w')
text(uR(6),vR(6),'6','FontSize',fsize,'FontWeight','bold','Color','w')
text(uR(7),vR(7),'7','FontSize',fsize,'FontWeight','bold','Color','w')
text(uR(8),vR(8),'','FontSize',fsize,'FontWeight','bold','Color','w')
[UR,VR] = ginput2(1);
plot(UR,VR,'bo','MarkerFaceColor','b','MarkerSize',msize)


Q = [L(1)-L(9)*UL,  L(2)-L(10)*UL,  L(3)-L(11)*UL;...
     L(5)-L(9)*VL,  L(6)-L(10)*VL,  L(7)-L(11)*VL;...
     R(1)-R(9)*UR,  R(2)-R(10)*UR,  R(3)-R(11)*UR;...
     R(5)-R(9)*VR,  R(6)-R(10)*VR,  R(7)-R(11)*VR];

q = [UL-L(4); VL-L(8); UR-R(4); VR-R(8)];

a_xyz = (Q'*Q)^-1*Q'*q;

% 

figure(1)
text(UL,VL,[num2str(a_xyz(1),2),',',num2str(a_xyz(2),2),',',num2str(a_xyz(3),2)],'FontSize',fsize,'FontWeight','bold','Color','w')
disp(a_xyz)

figure(2)
text(UR,VR,[num2str(a_xyz(1),2),',',num2str(a_xyz(2),2),',',num2str(a_xyz(3),2)],'FontSize',fsize,'FontWeight','bold','Color','w')
% disp(a_xyz)
