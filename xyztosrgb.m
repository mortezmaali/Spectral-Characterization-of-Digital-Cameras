function SRGB = xyztosrgb(XYZ)
%Calculate the normalized 3x3 matrix
NMat=[3.2406,-1.5372,-0.4986;-0.9689,1.8758,0.0415;0.0557,-0.2040,1.0570]*(XYZ/100);
%Declare the size of k so as to equal Nornalized 3x3 matrix
k=size(NMat);
%Set the values of SRGB to zero
SRGB=zeros(k(1),k(2));
%Loop to calculate SRGB values for each XYZ values row by row for each
%column
for i=1:k(2)
    if NMat(1,i) <= 0.0031308
        SRGB(1,i)=12.92*NMat(1,i);
    else
        SRGB(1,i)=(1+0.055)*NMat(1,i)^(1/2.4)-0.055;
    end
    if NMat(2,i) <= 0.0031308
        SRGB(2,i)=12.92*NMat(2,i);
    else
        SRGB(2,i)=(1+0.055)*NMat(2,i)^(1/2.4)-0.055;
    end
    if NMat(3,i) <= 0.0031308
        SRGB(3,i)=12.92*NMat(3,i);
    else
        SRGB(3,i)=(1+0.055)*NMat(3,i)^(1/2.4)-0.055;
    end
end

     