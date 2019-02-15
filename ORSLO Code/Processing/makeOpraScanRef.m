function  img = makeOpraScanRef(name,prefix,bg)
    try
        load(['scanref' prefix '.mat'],'img');
    catch
    num_imgs = 0;
    num_folders = 1;
    img = zeros(size(bg));
    while num_imgs < 500
        cd(name(num_folders).name)
        list = dir('*.png');
        
        for i = 1:length(list)
            img = img + double(imread(list(i).name))-bg;
        end
        
        num_imgs = num_imgs + length(list);
        num_folders = num_folders + 1;
        cd ..
    end
    img = img/num_imgs;
    save(['scanref' prefix '.mat'],'img')
    end
end
        
    