function  [] = scaleCrop(list,scanref,bg,cropMat,stuckY,stuckX)
    for i = 1:length(list)
       cd(list(i).name);
       mkdir('proc');
       
       pnglist = dir('*.png');
       
       Y = cropMat(2):(cropMat(2)+cropMat(4));
       X = cropMat(1):(cropMat(1)+cropMat(3));
       
       scanref(scanref==0) = NaN;
       
       for j = 1:(length(pnglist))
           img = double(imread(pnglist(j).name));
           img = (((img(Y,X))./scanref(Y,X))');
           img(stuckY,stuckX) = NaN;
           img = imnorm(img);
           
           imgContrast = round(nansum(nansum(img.^2))/(nansum(nansum(img))^2)*100000000);
           img(isnan(img)) = nanmean(img(:));
           imwrite(img,['proc/' num2str(imgContrast) pnglist(j).name '.png']);
       end
       cd ..
    end