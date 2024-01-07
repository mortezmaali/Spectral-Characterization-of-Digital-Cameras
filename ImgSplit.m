fprintf('Select the flat_fielded img folder:\n')
folder_img = uigetdir;
listing = dir(folder_img);
for i = 1:size(listing,1)

    [pathstr,name,ext] = fileparts(listing(i).name);
    if strcmpi(ext,'.tiff') | strcmpi(ext,'.tif')
        
        Img_nam = [name ext];
        
            
        Img = im2double(imread([folder_img '/' Img_nam]));
        slotR = Img(:,:,1);
        imwrite(slotR,[folder_img '/' 'slot1.tif'])
        slotG = Img(:,:,2);
        imwrite(slotG,[folder_img '/' 'slot2.tif'])
        slotB = Img(:,:,3);
        imwrite(slotB,[folder_img '/' 'slot3.tif'])
    end
    
end