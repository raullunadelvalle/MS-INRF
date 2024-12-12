clear all
close all
clc


single_vs_complex = 1; 
% 0:load single grating spatiotemporal map
% 1:load complex grating spatiotemporal map

if single_vs_complex == 0
    load('SpatioTemporal_map_1stOrder.mat', 'out_stdwNw_tFrec', 'dir','s_frec','t_frec','ctr','ph','angle','DegStim','imSize','Secs','fr',...
        'Nw','stdw','lambda','p','q')
elseif single_vs_complex == 1
    load('SpatioTemporal_map_complex.mat', 'out_stdwNw_tFrec', 'dir','s_frec','s_frec_fixed','t_frec','t_frec_fixed','ctr','ph_fixed','ph_variable','angle','DegStim','imSize','Secs','fr',...
        'Nw','stdw','lambda','p','q')   
end

numel_Nw = 1;


%% SPATIO-SPEED SELECTIVITY

iter = 0;
for aa = numel_Nw
for bb = 1:length(stdw)
    iter = iter+1;

    out_tFrec = cell2mat(out_stdwNw_tFrec(aa,bb));
    %out_tFrec(out_tFrec<=0.5) = NaN;

    out_tFrec(out_tFrec<0) = 0;
    out_tFrec = log(out_tFrec);



    out_tFrec( (27.*size(out_tFrec,1)) ./ max(t_frec):(30.*size(out_tFrec,1)) ./ max(t_frec),...
        : ) = [];
    out_tFrec( :,...
        (8.5.*size(out_tFrec,2)) ./ max(s_frec):(10.*size(out_tFrec,2)) ./ max(s_frec) ) = [];



    out_tFrec = flipud(out_tFrec);



    figure(iter)
    b = imagesc(out_tFrec);
    set(b,'AlphaData',~isnan(out_tFrec))
    caxis manual
    caxis([-1 1]);
    
    cob = colorbar;
    c.LineWidth = 3;
    
    xticks(([0:0.5:10].*size(out_tFrec,2)) ./ 8.5)
    xticklabels([0:0.5:10])
    xlabel('Spatial frequency (c/deg)')
    


    yticks(([0:2:30].*size(out_tFrec,1)) ./ 27)
    yticklabels(27:-2:0) 
    ylabel('Temporal frequency (Hz)')


    title("stdw=" + stdw(bb) + ", Nw=" + Nw(aa) + ""); 


    set(gca,'linewidth',2)
    set(gca,'FontSize',20)
    set(gcf,'color','w');
    axis square




end
end


%figure(99);plot(out_tFrec(34,:))
