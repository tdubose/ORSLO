M = 0.288; % mm/deg
imgSize = 250;
FOV_deg = 0.65*250/754;%
maxCycles = 120;
factor = 5;
imgSize2 = imgSize*factor;
padFactor =0;
padAmt = padFactor*round(imgSize/2);
freqX = 0:1/(FOV_deg*(factor)):(imgSize/(FOV_deg))/2;
freqX_reduced = freqX(freqX<=maxCycles);
halfLengthFFT = length(freqX_reduced);
s = sqrt(conesPerMM)*0.288;

k = 0.291;
C = 1;

s = k * sqrt(2*conesPerMM/sqrt(3));


f =  freqX_reduced;
fMM = freqX_reduced/k;
Ncones = C*fMM.^2;

reweightInverse = (sqrt(Ncones*C))*k*2;

coneAxis = Ncones;



%s = 288/5.92;%47;%92;%M/sqrt(sqrt(3)/(2*D)); % cycles/deg


h = hist(double(M1img(:)),51);
M1histeq = histeq(imnorm(M2img),h);


[radLine_red_M2,fftImg_red_M2] = getFFT_and_radLine(M2img,imgSize,...
    padAmt,factor,freqX,maxCycles,imgSize2,halfLengthFFT);

[radLine_red_M1,fftImg_red_M1] = getFFT_and_radLine(M1img,imgSize,...
    padAmt,factor,freqX,maxCycles,imgSize2,halfLengthFFT);

[radLine_red_M1_eq,fftImg_red_M1_eq] = getFFT_and_radLine(M1histeq,imgSize,...
    padAmt,factor,freqX,maxCycles,imgSize2,halfLengthFFT);

fft_x = linspace(-maxCycles,maxCycles,size(fftImg_red_M2,2));
fft_y = linspace(-maxCycles,maxCycles,size(fftImg_red_M2,1));

radLine_red_M1 = smooth(radLine_red_M1,5);
radLine_red_M2 = smooth(radLine_red_M2,5);
radLine_red_M1_eq = smooth(radLine_red_M1_eq,5);
fontSize = 36;

normed = radLine_red_M2(:);

h = figure(6);set(gcf,'color','white')
set(h,'units','normalized','position',[.1 .1 .6 .65]); 
% semilogy(freqX_reduced,radLine_red_M1,'-','Color',lineColor,'LineWidth',2.0);
% hold on;
semilogy(freqX_reduced,radLine_red_M1,'-','Color',lineColor,'LineWidth',3.5);
hold on;
semilogy(freqX_reduced,radLine_red_M2,':','Color',lineColor,'LineWidth',3.5);
semilogy(freqX_reduced,radLine_red_M1_eq,'--','Color',lineColor,'LineWidth',3.5);hold on

line([s s],[1 1e6],...
    'LineWidth',2.0,'Color',[0 0 0]);
hold off;

subsetIntensities = normed();

% legend('M = 1 (WFE)','M = 1 (WFE + HM)','M = 2 (OPRA)',['Curcio et al. 1990 (' int2str(conesPerMM/1000) 'e3 cones/mm^2)'],'Location','southwest');
legend('WFE SLO','ORSLO','ORSLO + HM', 'Curcio et al. 1990','Location','southwest');
axis([min(freqX_reduced(:)) max(freqX_reduced(:)) ...
    min(subsetIntensities(:))*1/2 max(subsetIntensities)*2]);
set(gca,'FontSize',fontSize,'FontWeight','bold','XGrid','on');
% set(gca,'Position',[.13 .11 .775 .815]);

xlabel('Radial Frequency (Cycles/Degree)','FontSize',fontSize,'FontWeight','Bold');
ylabel('Log_{10} - Power','FontSize',fontSize,'FontWeight','Bold');
%title('Radial power spectrum: Bottom Inset',...
%    'FontSize',fontSize,'FontWeight','Bold');
% pbaspect([1.6 1 1]);
saveas(h,['RadialPowerSpect_comparison_' M2_name 'v3.png']);