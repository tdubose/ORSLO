% create averaged backgrounds
% 
% M1_bg_dir = dir('bg_M1*');
% bg_M1 = makeOpraBg(M1_bg_dir,'M1');
% 
% M2_bg_dir = dir('bg_M2*');
% bg_M2 = makeOpraBg(M2_bg_dir,'M2');
% 
% % create scanned intensity reference and crop points
% 
% M1_dir = dir('M1*');
% scanref_M1 = makeOpraScanRef(M1_dir,'M1',bg_M1);
% figure(1); imagesc(scanref_M1);
% h= imrect; cropMatM1 = round(wait(h));
% close;

M2_dir = dir('M2*');
scanref_M2 = makeOpraScanRef(M2_dir,'M2',zeros(size(bg_M2)));
figure(2); imagesc(scanref_M2);
h= imrect; cropMatM2 = round(wait(h));
close;

% return

% scaleCrop(M1_dir,scanref_M1,bg_M1,cropMatM1,487,601);
scaleCrop(M2_dir,scanref_M2,bg_M2,cropMatM2,1,1);