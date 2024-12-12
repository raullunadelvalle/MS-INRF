clear all
close all
clc


% Stimulus parameters
dir = -1;
ctr = 0.9;
speed = linspace(8.5,8.5,1);

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

num_simulation = 10; 


%% REVERSE-PHI WITH RESPECTO TO SPEED

out_final_nr = zeros(num_simulation,1);
out_final_r = zeros(num_simulation,1);
out_nr_mean = zeros(1,length(speed));   
out_r_mean = zeros(1,length(speed)); 
out_nr_std = zeros(1,length(speed));   
out_r_std = zeros(1,length(speed)); 

for i = 1:length(speed)
    for j = 1:num_simulation
    simulation = j
    i
    
        reverse = 0;
        L_nr = reverse_phi(dir,ctr,reverse,speed(i), DegStim,imSize,Secs,fr); 


        reverse = 1;
        L_r = reverse_phi(dir,ctr,reverse,speed(i), DegStim,imSize,Secs,fr);

        out_final_nr(j,1) = mean( INRF_motion(L_nr,DegStim,imSize,fr,Secs, stdw,Nw,lambda,p,q, LGN) ); 
        out_final_r(j,1) = mean( INRF_motion(L_r,DegStim,imSize,fr,Secs, stdw,Nw,lambda,p,q, LGN) ); 
    
    end
    out_nr_mean(1,i) = mean(out_final_nr);   
    out_r_mean(1,i) = mean(out_final_r);

    out_nr_std(1,i) = std(out_final_nr)/sqrt(j);   
    out_r_std(1,i) = std(out_final_r)/sqrt(j);   
end


% figure(1)
% plot(speed,out_nr_mean,LineWidth=3)
% hold on;
% plot(speed,out_r_mean,LineWidth=3)
% hold on;
% yline(0)
% ylabel('Response')
% xlabel('Speed (deg/sec)');
% axis([1 15 -1 3])
% set(gca,'linewidth',2)
% set(gca,'FontSize',20)
% set(gcf,'color','w');
% box off
% legend('Non-reverse-phi','Reverse-phi')



figure(2)
bar([out_nr_mean out_r_mean],'FaceColor',[0.3010 0.7450 0.9330],'EdgeColor',[0.3010 0.7450 0.9330])
hold on;
err = errorbar([out_nr_mean out_r_mean],[out_nr_std out_r_std],'k',LineStyle='none');
err(1).LineWidth = 2;
axis([0 3 -0.2 0.5])


yline(0,'Color','k',LineWidth=2,LineStyle=":")
ylabel('Mean response')
xticklabels({'Non-reverse-phi','Reverse-phi'})


set(gca,'linewidth',2)
set(gca,'FontSize',20)
set(gcf,'color','w');
box off

axis square

