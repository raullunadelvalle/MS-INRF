clear all
close all
clc

% Stimulus parameters
dir = -1;
t_frec = 4; 
s_frec = 1.5; 
ctr = 0.9;
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
stdw = 0.125; 
Nw = 0.05; 
lambda = -30;
p = 0.4; 
q = 0.1; 


LGN = 0;


out_sqr = zeros(length(t_frec),length(s_frec));
out_miss = zeros(length(t_frec),length(s_frec));

out_sqr_cell = cell(1,length(ph));
out_miss_cell = cell(1,length(ph));

for nn = 1:length(ph)
    nn
    phase = ph(nn);

    for i = 1:length(t_frec)
    for j = 1:length(s_frec)
    
        missing = 0;
        L_sqr = missing_fundamental_tempFrec(dir,s_frec(j),t_frec(i),ctr,missing,angle,phase, DegStim,imSize,Secs,fr); 

        missing = 1;
        L_miss = missing_fundamental_tempFrec(dir,s_frec(j),t_frec(i),ctr,missing,angle,phase, DegStim,imSize,Secs,fr);
 
        out_sqr(i,j) = mean( INRF_motion(L_sqr,DegStim,imSize,fr,Secs, stdw,Nw,lambda,p,q, LGN) ); 
        out_miss(i,j) = mean( INRF_motion(L_miss,DegStim,imSize,fr,Secs, stdw,Nw,lambda,p,q, LGN) ); 
    end
    end

    out_sqr_cell{nn} = out_sqr;
    out_miss_cell{nn} = out_miss;

end

out_sqr_mean = mean(cat(3,out_sqr_cell{:}),3);
out_sqr_std = std(cat(3,out_sqr_cell{:}),[],3)/sqrt(nn);

out_miss_mean = mean(cat(3,out_miss_cell{:}),3);
out_miss_std = std(cat(3,out_miss_cell{:}),[],3)/sqrt(nn);



% figure(1)
% subplot(2,1,1)
% plot(s_frec,out_sqr,LineWidth=3)
% hold on;
% yline(0)
% xlabel('Spatial frequency (c/deg)')
% ylabel('Response Square wave')
% %axis([0 max(s_frec) -1500 2500])
% 
% %title(sprintf('dir=%d, ctr=%.1f, phase=0, stdw=%d, stdm=stdw/4, Nw=Nm=%d, lambda=%d, p=%.1f, q=%.1f',dir, ctr, stdw, Nw, lambda, p, q))
% 
% subplot(2,1,2)
% plot(s_frec,out_miss,LineWidth=3)
% hold on;
% yline(0)
% xlabel('Spatial frequency (c/deg)')
% ylabel('Response Missing fundamental')
% %axis([0 max(s_frec) -1500 2500])
% 
% legend({'1' '2' '3' '4' '5' '6'})


figure(2)
bar([out_sqr_mean out_miss_mean],'FaceColor',[0.3010 0.7450 0.9330],'EdgeColor',[0.3010 0.7450 0.9330])
hold on;
err = errorbar([out_sqr_mean out_miss_mean],[out_sqr_std out_miss_std],'k',LineStyle='none');
err(1).LineWidth = 2;

yline(0,'Color','k',LineWidth=2,LineStyle=":")
ylabel('Mean response')
xticklabels({'Square','Missing'})
axis([0 3 -0.65 0.65])

set(gca,'linewidth',2)
set(gca,'FontSize',20)
set(gcf,'color','w');
box off

axis square


