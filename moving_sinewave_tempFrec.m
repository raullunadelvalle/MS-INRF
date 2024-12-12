
function L = moving_sinewave_tempFrec(dir,sf,tf,c,phase,angle, Deg,S,Secs,fr) 

% dir = direction (-1: rightward, 1: leftward)
% sf = spatial frequency (cycles/deg)
% tf = temporal frequency (c/sec)
% c = contrast (0-1)
% phase = stimulus phase
% angle: stimulus orientation 
% Deg = degrees of visual angle subtended by stimulus 
% S = Spatial extention of display (pixels)
% Secs = Temporal duration of display (in seconds)
% fr = frame rate of display


T = Secs*fr; %Temporal extention of display (number of frames). Assuming a screen
% that works on fr=120, when Secs=1, T is 120 frames


[x,y] = meshgrid(-Deg/2:(Deg/S):((Deg/2)-(Deg/S)), ...
    ((Deg/2)):-(Deg/S):-((Deg/2)-(Deg/S)));

Angle = angle*pi/180;
xx=x.*cos(Angle)+y.*sin(Angle);
yy=-x.*sin(Angle)+y.*cos(Angle);



direction = (-1)*dir; 
spt_frec = sf;
temp_frec = tf;
mm = c;
ph = phase;


    ifi = 1/fr; 
    t = -ifi;


    M = zeros(T,S);
    for i = 1:T
        t = t+ifi;

        if spt_frec == 0
            stimulus2D = 0.5.*ones(size(xx));
        else
            wave = cos(2*pi*(spt_frec*xx-direction*temp_frec*t) + ph);
            stimulus2D = 0.5.*(1+(mm*wave));
        end


%          imshow(stimulus2D);impixelinfo


        M(i,:) = stimulus2D([S],[1:S]);
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