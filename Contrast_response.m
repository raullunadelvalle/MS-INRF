clear all
close all
clc

% Stimulus parameters
dir = -1;
t_frec = 4;
s_frec = 2; 
speed = t_frec / s_frec;
ctr1 = linspace(0,1,20); 
ctr1(1) = 0.01;
ctr = zeros(1,length(ctr1)+1);
ctr(3:length(ctr1)+1) = ctr1(2:end);
ctr(1:2) = [ctr1(1) 0.025];

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


out = zeros(length(ph),length(ctr));

for nn = 1:length(ph)
    phase = ph(nn);

    for i = 1:length(ctr)
        L = moving_sinewave(dir,s_frec,speed,ctr(i),phase,angle, DegStim,imSize,Secs,fr); 
        out(nn,i) = mean( INRF_motion(L,DegStim,imSize,fr,Secs, stdw,Nw,lambda,p,q, LGN) );
    end

end
out_mean = mean(out);
out_std = std(out)/sqrt(nn);



figure(1)
lg = loglog(ctr,out_mean,'k-o','MarkerFaceColor','k');
lg(1).LineWidth = 3;
hold on;
err = errorbar(ctr,out_mean,out_std,'vertical','k')
err(1).LineWidth = 2;

% Set transparency level (0:1)
alpha = 0.65;   
% Set transparency
set([err.Bar, err.Line], 'ColorType', 'truecoloralpha', 'ColorData', [err.Line.ColorData(1:3); 255*alpha])


%xticks([1:5:length(out_mean)])
%xticklabels(round(ctr(1:5:length(out_mean))))
xlabel('Contrast')

%yticks([out_mean])
%yticklabels([out_mean])
ylabel('Mean response')

axis([-0.2 1.2 1.16 2.4]) 

set(gca,'linewidth',2)
set(gca,'FontSize',20)
set(gcf,'color','w');
box off
axis square



