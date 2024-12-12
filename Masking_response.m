clear all
close all
clc


% Stimulus parameters
dir = -1;
tf_s = 10; 
sf_s = 2.5; 
sf_n = linspace(0,10,30); 
Hz_n = 10;
v_s = tf_s / sf_s;
ctr_s = 0.4; 
ctr_n = 0.4; 
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
sen_pos = 1;
sen_overlap = 0;

LGN = 0;


out_signal = zeros(1,length(ph));
for nn = 1:length(ph)
    phase_s = ph(nn);
    phase_n = 0; %no need to test range
    L_signal = masking_sinewave(dir,sf_s,0,Hz_n,v_s, ctr_s,0,phase_s,phase_n,angle,DegStim,imSize,Secs,fr); 
    out_signal(nn) = mean( INRF_motion(L_signal,DegStim,imSize,fr,Secs, stdw,Nw,lambda,p,q, LGN) ); 
end

out_signal_mean = mean(out_signal);
out_signal_mean = repmat(out_signal_mean,length(sf_n),1)';

out_signal_std = std(out_signal)/sqrt(nn);
out_signal_std = repmat(out_signal_std,length(sf_n),1)';


out = zeros(1,length(ph));
out_noise_mean = zeros(1,length(sf_n));
out_noise_std = zeros(1,length(sf_n));
for i = 1:length(sf_n)
    sf_n(i)
    count=0;
    for nn = 1:length(ph)
        phase_s = ph(nn);
        
        for ph_n = 0 %no need to test range
            phase_n = ph_n;
            count=count+1;
            L_mask = masking_sinewave(dir,sf_s,sf_n(i),Hz_n,v_s, ctr_s,ctr_n,phase_s,phase_n,angle,DegStim,imSize,Secs,fr); 
            out(nn) = mean( INRF_motion(L_mask,DegStim,imSize,fr,Secs, stdw,Nw,lambda,p,q, LGN) );
        end
    end

out_noise_mean(i) = mean(out);
out_noise_std(i) = std(out)/sqrt(nn);
end



figure(1)
p1 = plot(sf_n,out_signal_mean,'--','Color',[0.9290 0.6940 0.1250]); 
p1(1).LineWidth = 1.5;
hold on;
p2 = plot(sf_n,out_noise_mean,'-o','Color',[0.3010 0.7450 0.9330],'MarkerFaceColor',[0.3010 0.7450 0.9330]);
p2(1).LineWidth = 3;

xline(sf_s,'Color',[0.9290 0.6940 0.1250],LineWidth=1.5,LineStyle=":")
ylabel('Mean response')
xlabel('Noise spatial frequency (c/deg)');
legend(sprintf('Signal:%.1f c/deg',sf_s),'Signal+Noise')

set(gca,'linewidth',2)
set(gca,'FontSize',20)
set(gcf,'color','w');
box off
axis square




figure(2)
p1 = plot(sf_n,out_signal_mean,'--','Color',[0.9290 0.6940 0.1250]); 
p1(1).LineWidth = 1.5;
hold on;
yline(out_signal_mean+out_signal_std,'Color',[0.9290 0.6940 0.1250],LineWidth=1,LineStyle=":")
hold on;
yline(out_signal_mean-out_signal_std,'Color',[0.9290 0.6940 0.1250],LineWidth=1,LineStyle=":")


p2 = plot(sf_n,out_noise_mean,'-o','Color',[0.3010 0.7450 0.9330],'MarkerFaceColor',[0.3010 0.7450 0.9330]);
p2(1).LineWidth = 3;
hold on;

err = errorbar(sf_n,out_noise_mean,out_noise_std,'vertical','Color',[0.3010 0.7450 0.9330]);
err(1).LineWidth = 2;
% Set transparency level (0:1)
alpha = 0.65;   
% Set transparency (undocumented)
set([err.Bar, err.Line], 'ColorType', 'truecoloralpha', 'ColorData', [err.Line.ColorData(1:3); 255*alpha])
hold on;

xline(sf_s,'Color',[0.9290 0.6940 0.1250],LineWidth=1.5,LineStyle=":")
ylabel('Mean response')
xlabel('Noise spatial frequency (c/deg)');
%legend(sprintf('Signal:%d c/deg',sf_s),'Signal+Noise')

set(gca,'linewidth',2)
set(gca,'FontSize',20)
set(gcf,'color','w');
box off
axis square

