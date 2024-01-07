%this function would calculate the amount of CIEXYZ tristimulus values, where, 
%E is the spectral power distribution of the illuminant, diag signifies a diagonal matrix whose diagonal entries are composed of the spectral power distribution of the illuminant,
%xyz denotes CIE standard observer color-matching functions , and R represents reflectance spectra of the specimens.
%E, R and xyx are of 81*1, 81*24 and 81*3 dimension, respectively.
function XYZ = CIEXYZ(E, xyz, R)
XYZ=(1/(E'*xyz(:,2)))*xyz'*(diag(E))*R;
end
