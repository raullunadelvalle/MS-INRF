
function L = reverse_phi(dir,m,reversephi,paso, Deg,S,Secs,fr) 
% dir = direction (-1: rightward, 1: leftward)
% m = contrast (0-1)
% reversephi: 0 non-reverse phi  1 reverse-phi
% paso: speed (deg/sec)
% Deg = degrees of visual angle subtended by stimulus 
% S = Spatial extention of display
% Secs = Temporal duration of display (in seconds)
% fr = frame rate of display


T = Secs*fr; %Temporal extention of display (number of frames). Assuming a screen
% that works on fr=120, when Secs=1, T is 120 frames

paso =  ( (paso*S)/fr ) / Deg; % paso in pixels per frame, not in deg/sec


c = m;


noise_orig=(2*(round(rand(5000,5000))-0.5));
noise(:,:)=noise_orig([5000-S+1:5000],[5000-S+1:5000]); 


M = zeros(T,S);

counter=0;
counter_noise=0;
for i=1:T
     
    counter=counter+1;
    

        counter_noise = round( counter_noise-(paso*dir) );
        noise(:,:)=noise_orig([5000-S+1:5000],[5000-S+1-counter_noise:5000-counter_noise]); 
        counter=0;
        if m==c
            if reversephi==1
                m=-c; % reverse phi.
            end 
            if reversephi==0
                m=c; % non-reverse phi.
            end  
        else
            m=c;
        end  


         
    stimulus2D=0.5*(1+m*noise);
   

    M(i,:)=stimulus2D([S],[1:S]);
end

L=M';

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

% figure(1)
% subplot(1,2,1)
% imshow(L);impixelinfo
% title('Spatiotemporal plot')
% xlabel('time')
% ylabel('space');