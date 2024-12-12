

function L = moving_bar(dir,Np,paso,pola, Deg,S,Secs,fr, edge) 

% dir = direction of bar (-1: right   1: left) 
% Np = Spatial width of bar (deg)
% paso = Speed of bar (deg/s)
% Deg = degrees of visual angle of display
% S = Spatial extention of display (pixels)
% Secs = Temporal duration of display (in seconds)
% fr = frame rate of display
% edge: 0: it is a moving bar  1: it is a moving edge

Np = ( (Np*S)/Deg ) -1; % Np in pixels, not in deg
paso = (paso*(S/Deg))/fr; % paso in pixels per frame, not in deg/sec


T = Secs*fr; %Temporal extention of display (number of frames). Assuming a screen
% that works on fr=120, when Secs=1, T is 120 frames



if pola == 1
    L = zeros(S,T)+0.1;
elseif pola == 0
    L = ones(S,T)-0.1;
end

for i=1:T

    emp=1+round((i-1)*paso);
    fin=round( min(emp+Np,S) );

    L(emp:fin,i)=pola;
end


if dir==1
    L=flipud(L);
end




if edge == 1
    if pola == 1
        for i = 1:size(L,1)
            [~, location] = max(L(i,:), [], 'omitnan');
            L(i,location:end) = pola; 
        end
    elseif pola == 0
        for i = 1:size(L,1)
            [~, location] = min(L(i,:), [], 'omitnan');
            L(i,location:end) = pola; 
        end
    end
end



% imshow(L);impixelinfo
% 
% xlabel('Space (deg)')
% ylabel('Time (sec)')
% 
% set(gca,'linewidth',2)
% set(gca,'FontSize',20)
% set(gcf,'color','w');
% box off