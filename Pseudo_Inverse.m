lightSource; 
load('Ref_Passport.mat');
REF=R_Pass;
E=D65(:,1:2:61);
XYZ=(100/(E*COL(:,2)))*COL'*(diag(E))*REF';

%Training Responses
load('Mean_Value.mat')
x=[C_sg];
RGB_L_Li = zeros(3,24);
RGB_L_Li(1,:) = 2.9886*x(1,:).^3 - 2.7192*x(1,:).^2 + 1.0938*x(1,:) - 0.0795;
RGB_L_Li(2,:) = 3.5466*x(2,:).^3 - 2.4484*x(2,:).^2 + 1.0044*x(2,:) - 0.0384;
RGB_L_Li(3,:) = 4.3369*x(3,:).^3 - 2.4791*x(3,:).^2 + 1.16788*x(3,:) - 0.0253;
RGB_L_Li = RGB_L_Li';

%Now let's obtain the matrix M (the transform matrix)
M=pinv(RGB_L_Li)*REF;

%Plotting the Matrix M and showing the three primaries in it
plot(400:10:700,M')

%Now, it is time for the testing sample
RGBt=imread('Med_A_N.tif');
RGBt=im2double(RGBt);
[m,n,c] = size(RGBt);
RGBt = reshape(RGBt,[m*n,3]);
x=RGBt;
RGB_t_li = zeros(m*n,3);
RGB_t_li(:,1) = 2.9886*x(:,1).^3 - 2.7192*x(:,1).^2 + 1.0938*x(:,1) - 0.0795;
RGB_t_li(:,2) = 3.5466*x(:,2).^3 - 2.4484*x(:,2).^2 + 1.0044*x(:,2) - 0.0384;
RGB_t_li(:,3) = 4.3369*x(:,3).^3 - 2.4791*x(:,3).^2 + 1.16788*x(:,3) - 0.0253;

% Recovery of the spectral reflectance of the testing sample
Rr=RGB_t_li*M;
Rr_reshap = reshape(Rr,[m n,31]);
figure(1);imshow(Rr_reshap(:,:,1))
figure(2);imshow(Rr_reshap(:,:,15))
figure(3);imshow(Rr_reshap(:,:,31))

XYZt=(100/(E*COL(:,2)))*COL'*(diag(E))*Rr';

SRGB = xyztosrgb(XYZt);
SRGB = min(max(SRGB,0),1);
rgb = im2uint8(SRGB); 
rgb = reshape(rgb',[m,n,3]);
imwrite(rgb, 'Pseudo.tif');