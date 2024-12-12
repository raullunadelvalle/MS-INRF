clear all
close all
clc


% Stimulus parameters
t_frec = 7; 
s_frec_mod = 1; 
s_frec_carr = 4; 
Hz_carr = 120;
speed = t_frec / s_frec_mod; 
ctr = 0.8;
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


out_final_right = zeros(length(ph),1);
out_final_left = zeros(length(ph),1);
out_right_mean = zeros(1,length(stdw));
out_left_mean = zeros(1,length(stdw));
out_right_std = zeros(1,length(stdw));
out_left_std = zeros(1,length(stdw));
for i = 1:length(stdw)
    i
    for j = 1:length(ph)
        phase = ph(j);
        dir = -1;
        L_right = second_order(dir,s_frec_carr,s_frec_mod,  Hz_carr  ,speed,ctr,phase,angle, DegStim,imSize,Secs,fr); 
        out_final_right(j,1) = mean( INRF_motion(L_right,DegStim,imSize,fr,Secs, stdw(i),Nw,lambda,p,q, LGN) ); 


        dir = 1;
        L_left = second_order(dir,s_frec_carr,s_frec_mod,  Hz_carr  ,speed,ctr,phase,angle, DegStim,imSize,Secs,fr); 
        out_final_left(j,1) = mean( INRF_motion(L_left,DegStim,imSize,fr,Secs, stdw(i),Nw,lambda,p,q, LGN) ); 

    end
    out_right_mean(1,i) = mean(out_final_right);
    out_right_std(1,i) = std(out_final_right)/sqrt(j);

    out_left_mean(1,i) = mean(out_final_left);
    out_left_std(1,i) = std(out_final_left)/sqrt(j);
end


figure(1)
bar([out_left_mean out_right_mean],'FaceColor',[0.3010 0.7450 0.9330],'EdgeColor',[0.3010 0.7450 0.9330])
hold on;
err = errorbar([out_left_mean out_right_mean],[out_left_std out_right_std],'k',LineStyle='none');
err(1).LineWidth = 2;

yline(0,'Color','k',LineWidth=2,LineStyle=":")
ylabel('Mean response')
xticklabels({'Left','Right'})
axis([0 3 -0.45 0.45])

set(gca,'linewidth',2)
set(gca,'FontSize',20)
set(gcf,'color','w');
box off

axis square



% figure(2)
% subplot(1,2,1)
% plot(stdw,out_right_mean,LineWidth=3)
% hold on;
% plot(stdw,out_left_mean,LineWidth=3)
% yline(0)
% ylabel('Response')
% xlabel('stdw (deg)');
% %axis([min(stdw) max(stdw) -2.3 2.3])
% 
% set(gca,'linewidth',2)
% set(gca,'FontSize',20)
% set(gcf,'color','w');
% box off
% 
% subplot(1,2,2)
% plot(stdw,out_right_mean + out_left_mean,LineWidth=3)
% yline(0)
% ylabel('Right-Left')
% xlabel('stdw (deg)');
% %axis([min(stdw) max(stdw) -0.5 0.5])
% 
% set(gca,'linewidth',2)
% set(gca,'FontSize',20)
% set(gcf,'color','w');
% box off

