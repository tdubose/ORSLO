function [] = opraHistEq(M1newCropY,M2newCropY)
    ref = imnorm(double(imread('refFrame.png')));
    refHist = hist(ref(:),51);
    close
    
    cd selected_M1
    
    list = dir('*.png');
    for i = 1:length(list)
        img = mean(double(imread(list(i).name)),3);
        img = img(M1newCropY,:);
        img = histeq(imnorm(img),refHist);
        imwrite(img,['proc' list(i).name]);
    end
    
    cd ../selected_M2
    
    list = dir('*.png');
    for i = 1:length(list)
        img = mean(double(imread(list(i).name)),3);
        img = img(M2newCropY,1:end);
        img = histeq(imnorm(img),refHist);
        imwrite(img,['proc' list(i).name]);
    end
    cd ..
end
    