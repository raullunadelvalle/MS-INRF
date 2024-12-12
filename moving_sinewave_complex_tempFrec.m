
function L = moving_sinewave_complex_tempFrec(dir,sf_variable,tf_variable,sf_fixed,tf_fixed,c,phase_variable,phase_fixed,angle, Deg,S,Secs,fr) 
% dir = direction (-1: rightward, 1: leftward)
% sf_variable / sf_fixed = spatial frequency of component 1 and component 2 (cycles/deg)
% tf_variable / tf_fixed = temporal frequency of component 1 and component 2 (c/sec)
% c = contrast (0-1)
% phase_variable / phase_fixed = stimulus phase of component 1 and component 2
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
spt_frec_variable = sf_variable;
temp_frec_variable = tf_variable;
spt_frec_fixed = sf_fixed;
temp_frec_fixed = tf_fixed;

mm = c;
ph_variable = phase_variable;
ph_fixed = phase_fixed;



    ifi = 1/fr; 
    t = -ifi; 


    M = zeros(T,S);
    for i = 1:T
        t = t+ifi;


        wave_fixed = cos(2*pi*(spt_frec_fixed*xx-direction*temp_frec_fixed*t) + ph_fixed);
        wave_variable = cos(2*pi*(spt_frec_variable*xx-direction*temp_frec_variable*t) + ph_variable);


        if spt_frec_variable == 0
            stimulus2D = 0.5.*(1+(mm*wave_fixed));
        else
            stimulus2D = 0.5.*(1+(mm*wave_variable+mm*wave_fixed)); 
        end



        %imshow(stimulus2D);impixelinfo




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