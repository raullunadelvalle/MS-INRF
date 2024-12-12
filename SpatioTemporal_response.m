clear all
close all
clc



%% SPATIO-TEMPORAL FREQUENCY SELECTIVITY

% Stimulus parameters
dir = -1;
s_frec = linspace(0,10,100);
t_frec = linspace(0,30,100);
ctr = 0.4; 
%phase range%%%
nPH = 10; 
ph = linspace(-pi,pi,nPH); 
%%%%%%%%%%%%%%%
angle = 0;


DegStim = 2;
imSize = 400;

Secs = 1;
fr = 120;


% INRF parameters
stdw = [0.125];
Nw = [0.05];
lambda = -30;
p = 0.4; 
q = 0.1; 

LGN = 0;


tic

out_stdwNw_tFrec = cell(length(Nw),length(stdw));
out_stdwNw_tFrec = cellfun(@(x) zeros(length(t_frec),length(s_frec)),out_stdwNw_tFrec,'UniformOutput',false);


a_Nw = 0;

    for aa = 1:length(Nw)
    Nw(aa)
    for bb = 1:length(stdw)
    stdw(bb)
    
        out_tFrec = zeros(length(t_frec),length(s_frec));
        for nn = 1:length(ph)
            phase = ph(nn);
    
            out_tFrec1 = zeros(length(t_frec),length(s_frec));
            for i = 1:length(t_frec)
            for j = 1:length(s_frec)
                L_tFrec = moving_sinewave_tempFrec(dir,s_frec(j),t_frec(i),ctr,phase,angle, DegStim,imSize,Secs,fr);
                out_tFrec1(i,j) = mean( INRF_motion(L_tFrec,DegStim,imSize,fr,Secs, stdw(bb),Nw(aa),lambda,p,q, LGN) );
            end
            end
            out_tFrec = (out_tFrec+out_tFrec1);

        end

        out_stdwNw_tFrec{aa,bb} = out_tFrec / nn;

    end
    end


cd 'SpatioTemporal_maps'

save('SpatioTemporal_map_1stOrder.mat', 'out_stdwNw_tFrec', 'dir','s_frec','t_frec','ctr','ph','angle','DegStim','imSize','Secs','fr',...
    'Nw','stdw','lambda','p','q')   


% figure(1)
% plot(s_frec,out_stdwNw_tFrec{1},LineWidth=3)
% yline(0,'LineStyle',':','LineWidth',2)
% xlabel('Spatial frequency (Hz)')
% ylabel('Response')
% 
% %axis([0 10 -0.25 3])
% set(gca,'linewidth',2)
% set(gca,'FontSize',20)
% set(gcf,'color','w');
% box off