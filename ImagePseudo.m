lightSource;
macNN;
REF=Mac;
E=D65(:,1:2:61);
REFCO=(100/(E*COL(:,2)))*COL'*(diag(E))*REF;
%Training Responses
RGBtr=[C_sg_Val_D_Te_L];
%C_sg_NiB_F_Tr;C_sg_NiS_F_Tr;C_sg_NiS_A_Tr;C_sg_Cann_A_Tr

M12=REFCO*pinv(RGBtr);



RGBt11=imread('color.png');
RGBt11=im2double(RGBt11);
[m,n,c] = size(RGBt11);
RGBt11 = reshape(RGBt11(:,:,1:3),[m*n,3]);
x=m*n;
RGBt11_L=zeros(x,3);
RGBt11_L(1:x,1)=0.5503*RGBt11(:,1).^3+0.1967*RGBt11(:,1).^2+0.4387*RGBt11(:,1)-0.0275;
RGBt11_L(1:x,2)=1.0903*RGBt11(:,2).^3-0.2857*RGBt11(:,2).^2+0.5072*RGBt11(:,2)-0.0268;
RGBt11_L(1:x,3)=-0.043*RGBt11(:,3).^3+1.0238*RGBt11(:,3).^2+0.1978*RGBt11(:,3)-0.0036;


% C_sg_med_A_Te_N_L(1,:)=2.7256*C_sg_med_A_Te_N(1,:).^3-2.1386*C_sg_med_A_Te_N(1,:).^2+0.8184*C_sg_med_A_Te_N(1,:)-0.0141;
% C_sg_med_A_Te_N_L(2,:)=2.7865*C_sg_med_A_Te_N(2,:).^3-1.7081*C_sg_med_A_Te_N(2,:).^2+0.9402*C_sg_med_A_Te_N(2,:)-0.0146;
% C_sg_med_A_Te_N_L(3,:)=2.9673*C_sg_med_A_Te_N(3,:).^3-1.582*C_sg_med_A_Te_N(3,:).^2+1.2555*C_sg_med_A_Te_N(3,:)-0.0025;
% 

%C_sg_NiB_F_Te;C_sg_NiS_F_Te;C_sg_NiS_A_Te;C_sg_Cann_A_Te
Rr12=M12*RGBt11_L';
SRGB = xyztosrgb(Rr12);
SRGB = min(max(SRGB,0),1);
rgb = im2uint8(SRGB); 
rgb = reshape(rgb',[m,n,3]);
imwrite(rgb, 'PseudoN1.tif');