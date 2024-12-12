clear all
close all
clc

% Stimulus parameters
width = 0.25;
speed = 2;

pola = 1;

DegStim = 2;
imSize = 400;

Secs = 1;
fr = 120;

edge = 0; %0: moving bar / 1:moving edge


% INRF parameters
stdw = 0.125; 
Nw = 0.05; 
lambda =-30;
p = 0.4; 
q = 0.1; 
sen_pos = 1;
sen_overlap = 0;

LGN = 0;


dir = -1;
L_white_right = moving_bar(dir,width,speed,pola, DegStim,imSize,Secs,fr, edge); 
L_black_right = moving_bar(dir,width,speed,0, DegStim,imSize,Secs,fr, edge);


out_white_right = INRF_motion(L_white_right,DegStim,imSize,fr,Secs, stdw,Nw,lambda,p,q, LGN); 
out_black_right = INRF_motion(L_black_right,DegStim,imSize,fr,Secs, stdw,Nw,lambda,p,q, LGN); 

dir = 1;
L_white_left = moving_bar(dir,width,speed,pola, DegStim,imSize,Secs,fr, edge); 
L_black_left = moving_bar(dir,width,speed,0, DegStim,imSize,Secs,fr, edge);

out_white_left = INRF_motion(L_white_left,DegStim,imSize,fr,Secs, stdw,Nw,lambda,p,q, LGN); 
out_black_left = INRF_motion(L_black_left,DegStim,imSize,fr,Secs, stdw,Nw,lambda,p,q, LGN); 


msecs = (1:10:fr)*(1/fr);



figure(1)
plot(out_white_right,'LineWidth',7,'Color',[0.9290 0.6940 0.1250])
hold on;
yline(0,'LineStyle',':','LineWidth',2)

xticks([1  200*fr/1000  400*fr/1000  600*fr/1000  800*fr/1000  1000*fr/1000])
xticklabels({'0' '200' '400' '600' '800' '1000'})
xlabel('Time (msec)')

yticks([-40:5:40])
yticklabels([-40:5:40])
ylabel('Response')

axis([0 fr*Secs -10 10])
set(gca,'linewidth',2)
set(gca,'FontSize',20)
set(gcf,'color','w');
box off

axis square


figure(2)
plot(out_black_right,':','LineWidth',7,'Color',[0.9290 0.6940 0.1250])
hold on;
yline(0,'LineStyle',':','LineWidth',2)

xticks([1  200*fr/1000  400*fr/1000  600*fr/1000  800*fr/1000  1000*fr/1000])
xticklabels({'0' '200' '400' '600' '800' '1000'})
xlabel('Time (msec)')

yticks([-40:5:40])
yticklabels([-40:5:40])
ylabel('Response')


axis([0 fr*Secs -10 10])
set(gca,'linewidth',2)
set(gca,'FontSize',20)
set(gcf,'color','w');
box off

axis square



figure(3)
plot(out_white_left,'LineWidth',7,'Color',[0.3010 0.7450 0.9330])
hold on;
yline(0,'LineStyle',':','LineWidth',2)

xticks([1  200*fr/1000  400*fr/1000  600*fr/1000  800*fr/1000  1000*fr/1000])
xticklabels({'0' '200' '400' '600' '800' '1000'})
xlabel('Time (msec)')

yticks([-40:5:40])
yticklabels([-40:5:40])
ylabel('Response')


axis([0 fr*Secs -10 10])
set(gca,'linewidth',2)
set(gca,'FontSize',20)
set(gcf,'color','w');
box off

axis square


figure(4)
plot(out_black_left,':','LineWidth',7,'Color',[0.3010 0.7450 0.9330])
hold on;
yline(0,'LineStyle',':','LineWidth',2)


xticks([1  200*fr/1000  400*fr/1000  600*fr/1000  800*fr/1000  1000*fr/1000])
xticklabels({'0' '200' '400' '600' '800' '1000'})
xlabel('Time (msec)')

yticks([-40:5:40])
yticklabels([-40:5:40])
ylabel('Response')


axis([0 fr*Secs -10 10])
set(gca,'linewidth',2)
set(gca,'FontSize',20)
set(gcf,'color','w');
box off

axis square


mean(out_white_right)
mean(out_black_right)

mean(out_white_left)
mean(out_black_left)

