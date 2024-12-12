
function L = missing_fundamental_tempFrec(dir,sf,t_frec,c,missing,angle,phase, Deg,S,Secs,fr) 

% dir = direction (-1: rightward, 1: leftward)
% sf = spatial frequency (cycles/deg)
% t_frec = temporal frequency Hz
% c = contrast (0-1)
% missing: 0 squarewave  1 missing fundamental
% angle: stimulus orientation 
% phase: stimulus phase
% Deg = degrees of visual angle subtended by stimulus 
% S = Spatial extention of display (pixels)
% Secs = Temporal duration of display (in seconds)
% fr = frame rate of display



T = Secs*fr; %Temporal extention of display (number of frames). Assuming a screen
% that works on fr=120, when Secs=1, T is 120 frames

quarter_cycle_jump = round( (1/4)*(S/sf) );%pixels per cycle


%%%Choose the stimulus type:
missingfundamental = missing; 

[x,y] = meshgrid(-Deg/2:(Deg/S):((Deg/2)-(Deg/S)), ...
    ((Deg/2)):-(Deg/S):-((Deg/2)-(Deg/S)));

Angle = angle*pi/180;
xx=x.*cos(Angle)+y.*sin(Angle);
yy=-x.*sin(Angle)+y.*cos(Angle);


direction = (-1)*dir;
s_frec = sf;
speed = direction*(t_frec/s_frec);
mm = c;



ifi = 1/fr; 
t = -ifi;


M = zeros(T,S);

counter=0;
for i=1:T

t = t+ifi;    

jump = round((66*fr)/(Secs*1000));
counter = counter+1;
if (counter == jump) || (i == 1)
    if missingfundamental==0
    stimulus2D=(4/pi)*sin(2*pi*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/3)*sin(2*pi*3*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/5)*sin(2*pi*5*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/7)*sin(2*pi*7*s_frec*(xx-speed*t)+phase)...
            +(4/pi)*(1/9)*sin(2*pi*9*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/11)*sin(2*pi*11*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/13)*sin(2*pi*13*s_frec*(xx-speed*t)+phase)...
             +(4/pi)*(1/15)*sin(2*pi*15*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/17)*sin(2*pi*17*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/19)*sin(2*pi*19*s_frec*(xx-speed*t)+phase)...
             +(4/pi)*(1/21)*sin(2*pi*21*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/23)*sin(2*pi*23*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/25)*sin(2*pi*25*s_frec*(xx-speed*t)+phase);
             +(4/pi)*(1/27)*sin(2*pi*27*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/29)*sin(2*pi*29*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/31)*sin(2*pi*31*s_frec*(xx-speed*t)+phase)...
             +(4/pi)*(1/33)*sin(2*pi*33*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/35)*sin(2*pi*35*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/37)*sin(2*pi*37*s_frec*(xx-speed*t)+phase);
    else
    stimulus2D=(4/pi)*(1/3)*sin(2*pi*3*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/5)*sin(2*pi*5*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/7)*sin(2*pi*7*s_frec*(xx-speed*t)+phase)...
            +(4/pi)*(1/9)*sin(2*pi*9*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/11)*sin(2*pi*11*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/13)*sin(2*pi*13*s_frec*(xx-speed*t)+phase)...
            +(4/pi)*(1/15)*sin(2*pi*15*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/17)*sin(2*pi*17*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/19)*sin(2*pi*19*s_frec*(xx-speed*t)+phase)...
            +(4/pi)*(1/21)*sin(2*pi*21*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/23)*sin(2*pi*23*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/25)*sin(2*pi*25*s_frec*(xx-speed*t)+phase)...
            +(4/pi)*(1/27)*sin(2*pi*27*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/29)*sin(2*pi*29*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/31)*sin(2*pi*31*s_frec*(xx-speed*t)+phase)...
            +(4/pi)*(1/33)*sin(2*pi*33*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/35)*sin(2*pi*35*s_frec*(xx-speed*t)+phase)+(4/pi)*(1/37)*sin(2*pi*37*s_frec*(xx-speed*t)+phase);
    end
tt = t;
counter = 0;
else
    if missingfundamental==0
    stimulus2D=(4/pi)*sin(2*pi*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/3)*sin(2*pi*3*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/5)*sin(2*pi*5*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/7)*sin(2*pi*7*s_frec*(xx-speed*tt)+phase)...
            +(4/pi)*(1/9)*sin(2*pi*9*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/11)*sin(2*pi*11*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/13)*sin(2*pi*13*s_frec*(xx-speed*tt)+phase)...
             +(4/pi)*(1/15)*sin(2*pi*15*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/17)*sin(2*pi*17*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/19)*sin(2*pi*19*s_frec*(xx-speed*tt)+phase)...
             +(4/pi)*(1/21)*sin(2*pi*21*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/23)*sin(2*pi*23*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/25)*sin(2*pi*25*s_frec*(xx-speed*tt)+phase);
             +(4/pi)*(1/27)*sin(2*pi*27*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/29)*sin(2*pi*29*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/31)*sin(2*pi*31*s_frec*(xx-speed*tt)+phase)...
             +(4/pi)*(1/33)*sin(2*pi*33*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/35)*sin(2*pi*35*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/37)*sin(2*pi*37*s_frec*(xx-speed*tt)+phase);
    else
    stimulus2D=(4/pi)*(1/3)*sin(2*pi*3*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/5)*sin(2*pi*5*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/7)*sin(2*pi*7*s_frec*(xx-speed*tt)+phase)...
            +(4/pi)*(1/9)*sin(2*pi*9*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/11)*sin(2*pi*11*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/13)*sin(2*pi*13*s_frec*(xx-speed*tt)+phase)...
            +(4/pi)*(1/15)*sin(2*pi*15*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/17)*sin(2*pi*17*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/19)*sin(2*pi*19*s_frec*(xx-speed*tt)+phase)...
            +(4/pi)*(1/21)*sin(2*pi*21*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/23)*sin(2*pi*23*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/25)*sin(2*pi*25*s_frec*(xx-speed*tt)+phase)...
            +(4/pi)*(1/27)*sin(2*pi*27*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/29)*sin(2*pi*29*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/31)*sin(2*pi*31*s_frec*(xx-speed*tt)+phase)...
            +(4/pi)*(1/33)*sin(2*pi*33*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/35)*sin(2*pi*35*s_frec*(xx-speed*tt)+phase)+(4/pi)*(1/37)*sin(2*pi*37*s_frec*(xx-speed*tt)+phase);
    end

end   


   
M(i,:)=0.5*(1+mm*stimulus2D([S],[1:S]));
end 
 L=M';



 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

% figure(1)
% subplot(1,2,1)
% imshow(L)
% title('Spatiotemporal plot')
% xlabel('time')
% ylabel('space');