function batchHistEq(refFile)
    img = imnorm(double(imread(refFile)));
    h = hist(img(:),51);
    list = dir('*.png*.png');
    
    for i = 1:length(list)
        img = imnorm(double(imread(list(i).name)));
        img = histeq(img,h);
        imwrite(img,['eq' list(i).name])
    end