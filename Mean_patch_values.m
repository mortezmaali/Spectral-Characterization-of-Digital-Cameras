fprintf('Select the flat_fielded img folder:\n')
folder_img = uigetdir;
listing = dir(folder_img);
indx = 1;
for i = 1:size(listing,1)

    [pathstr,name,ext] = fileparts(listing(i).name);
    if strcmpi(ext,'.tiff') | strcmpi(ext,'.tif')
        
        Img_name{indx} = [name ext];
        
            
        Img{indx} = im2double(imread([folder_img '/' Img_name{indx}]));
        indx = indx + 1;
    end
    
end
indx=3;
s = [4 6];
[mask,coor] = patchmask(Img{1}/max(Img{1}(:)),0.4,s);

 for i = 1:indx
for j = 1:24
         img = im2double(imread(strcat(folder_img,'/','slot',num2str(i),'.tif')));
        C_sg(i,j) = mean(mean(img(find(mask == j))));
    end
 end  
fprintf('Select the result folder:')
folder = uigetdir;
%save as mat file
save([folder,'/','Mean_Value.mat'],'C_sg');
%save as Excel file
filename='mean_value';
xlswrite([folder,'/',filename],C_sg)
