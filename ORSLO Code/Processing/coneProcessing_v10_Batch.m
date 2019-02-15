% Cone 1stImgSet

folder = uigetdir();

cd(folder);


conesPerMMs = fliplr(([45e3, 27e3, 21e3]));%([29.3e3, 26.1e3, 22.8e3]);
lineColors = flipud([238., 34., 12.; 0, 162, 255. ;29. 177. 0;]/255);
fileStubs= ({'Green','Yellow','Red'});

for i = 1:3
    lineColor = lineColors(i,:);
    conesPerMM = conesPerMMs(i);
    M2_name =  ['M2' fileStubs{i} '.png'];
    
    M2img = imnorm(double(imread(M2_name)));
    
    M1img = imnorm(double(imread([  'M1' fileStubs{i} '.png'])));
    
    coneProcHelperconeAxis
    imwrite((M1histeq),['M2' fileStubs{i} '_eq.png']);
end