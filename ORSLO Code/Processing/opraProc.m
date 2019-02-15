list = dir('*.opra');
parfor i =1:length(list)
    fname = list(i).name;
    f = fopen(fname);
    mkdir(fname(1:end-5));
    cd(fname(1:end-5));
    noFrames = 0;
    while ~feof(f)
        num = fread(f,1,'int32');
        if isempty(num)
            break
        end
        mm = reshape(double(fread(f,num,'uint16')),1536,2048);
        mm = (mm-min(min(mm)))/(max(max(mm))-min(min(mm)));
        imwrite(mm,['frame' int2str(noFrames) '.png']);
        noFrames = noFrames + 1;
    end
    cd ..
    fclose(f);
    movefile(fname,fname(1:end-5))
end
        