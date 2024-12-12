
function L = second_order(dir,sf_c,sf_m,  Hz_carr  ,v,c,phase,angle, Deg,S,Secs,fr)

% dir = direction (-1: rightward, 1: leftward)
% sf_c = spatial frequency "carrier" (cycles/deg)
% sf_m = spatial frequency "modulator" (cycles/deg)
% Hz_carr = temporal frequency of jittering carrier
% v = speed "modulator" (deg/sec)
% c = contrast (0-1)
% phase = phase of "modulator" in rad
% angle: stimulus orientation 
% Deg = degrees of visual angle subtended by stimulus 
% S = Spatial extention of display
% Secs = Temporal duration of display (in seconds)
% fr = frame rate of display



T = Secs*fr; %Temporal extention of display (number of frames). Assuming a screen
% that works on fr=120, when Secs=1, T is 120 frames


K = 0.3; %modulation depth


[x,y] = meshgrid(-Deg/2:(Deg/S):((Deg/2)-(Deg/S)), ...
    ((Deg/2)):-(Deg/S):-((Deg/2)-(Deg/S)));
Angle = angle*pi/180;
xx=x.*cos(Angle)+y.*sin(Angle);
yy=-x.*sin(Angle)+y.*cos(Angle);


direction = (-1)*dir;
speed = v;
mm = c;
ph = phase;



    ifi = 1/fr; 
    t = -ifi; 

    T_Hz = 1:1:120;
    T_Hz = T_Hz(1:round(T/Hz_carr):end);

    
    M = zeros(T,S);
    for i=1:T
        t = t+ifi;


        if ismember(i,T_Hz)
            ph_carrier = 2*(rand(1)-0.5)*pi;
            % %Uncomment in case you want static carrier
            %ph_carrier=ph_carrier; 
        end        

        carrier = cos(2*pi*sf_c*(xx) + ph_carrier);
        modulator = cos(2*pi*sf_m*(xx-direction*speed*t) + ph);
    
        if sf_m == 0
            stimulus2D = ([0.5.*(1+K.*(1+mm*ones(size(xx))).*carrier)]);
        else
            stimulus2D = ([0.5.*(1+K.*(1+mm*modulator).*carrier)]);
        end


        M(i,:) = stimulus2D([S],[1:S]);
    end
    L=M';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% figure(1)
% subplot(1,2,1)
% imshow(L)
% title('Spatiotemporal plot')
% xlabel('time')
% ylabel('space');

