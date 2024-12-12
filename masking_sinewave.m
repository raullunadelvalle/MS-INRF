
function L = masking_sinewave(dir,sf_s,sf_n,Hz_n,v_s,c_s,c_n,phase_s,phase_n,angle, Deg,S,Secs,fr)

% dir: direction, -1 right, 1 left
% sf_s / sf_n: spatial frequency signal/noise (cycles/deg)
% Hz_n: temporal frequency of the jittering noise
% v_s: speed signal (deg/sec)
% c_s / c_n: contrast signal/noise (0-1)
% phase_s / phase_n:  phase signal/noise 
% angle: stimulus orientation 
% Deg : degrees of visual angle subtended by stimulus 
% S = Spatial extention of display (pixels)
% Secs = Temporal duration of display (in seconds)
% fr = frame rate of display


T = Secs*fr; %Temporal extention of display (number of frames). Assuming a screen
% that works on fr=120, when Secs=1, T is 120 frames

freq_signal = sf_s;
freq_noise = sf_n;
speed_signal = v_s;
contrast_signal = c_s;
contrast_noise = c_n;
phase_signal = phase_s;
phase = phase_n;



direction = (-1)*dir;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[x,y] = meshgrid(-Deg/2:(Deg/S):((Deg/2)-(Deg/S)), ...
    ((Deg/2)):-(Deg/S):-((Deg/2)-(Deg/S)));

Angle = angle*pi/180;
xx=x.*cos(Angle)+y.*sin(Angle);
yy=-x.*sin(Angle)+y.*cos(Angle);


ifi = 1/fr;
t = -ifi;

T_Hz = 1:1:120;
T_Hz = T_Hz(1:round(T/Hz_n):end);


M = zeros(T,S);
for i=1:T
    t=t+ifi;
    
    contrastmodulation(i)=1;


    if ismember(i,T_Hz)
        phase=2*(rand(1)-0.5)*pi;
    end


    if freq_noise>0
        noise = contrast_noise*cos(2*pi*xx*freq_noise+phase);
    else    
        noise =  0.*ones(size(xx));
    end

    if freq_signal==0 && freq_noise==0
        stimulus2D = 0.5.*ones(size(xx));
    else
        signal = contrast_signal*cos(2*pi*freq_signal*(xx-direction*speed_signal*t)+phase_signal);
        stimulus2D=0.5*(1+(contrastmodulation(i)*(signal+noise)));
    end
    
%     imshow(stimulus2D);

    M(i,:)=stimulus2D([S],[1:S]);
end
L=M';


% figure(2)
% imshow(L); %impixelinfo
% 
% xlabel('Space (deg)')
% ylabel('Time (sec)')
% 
% set(gca,'linewidth',2)
% set(gca,'FontSize',20)
% set(gcf,'color','w');
% box off