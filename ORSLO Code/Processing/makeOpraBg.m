 function  img = makeOpraBg(name,prefix)
    try
        load(['bg' prefix '.mat'],'img')
    catch
        cd(name(1).name);
        list = dir('*.png');
        
        img = double(imread(list(1).name));
        
        for i = 2:length(list)
            img = img + double(imread(list(i).name));
        end
        
        img = img/length(list);
        
        cd ..
        save(['bg' prefix '.mat'],'img')
    end
    
    