function out = INRF_motion(Stim,DegStim,imSize,frStim,Secs,stdw,Nw,lambda,p,q, LGN)

%Stim: Stimulus
%DegStim: deg subtended by the stimulus
%Imsize: size of stimulus in pixels
%frStim: framerate of stimulus (frames/sec)
%Secs: duration in sects of the stimulus

% INRF PARAMETERS
%stdw: in deg
%Nw: in seconds
%lambda,p,q: arbitrary units

%LGN: 1: Simulates LGN filtering stage  0: No LGN filtering stage
%bar: set to 1 if the stimulus processed is a bar


stdw = (  ( ( stdw*(size(Stim,1)/DegStim) ) )  ); 
stdm = stdw/4;


Nw = Nw*frStim;% transform Nw in seconds to frames
Nm = Nw;


L = Stim;

r=[1:Nm];
r=r./Nm;

t = linspace(0,20,length(r)); %

k=1;
n=5;

Tm=(k*t).^n.*exp(-k*t).*(1/factorial(n) - (k*t).^2/factorial(n+2) );

r=[1:Nw];
r=r./Nw;


Tw=cos(0.5*pi*r);


x0 = round(size(L,1)/2);

Nx = size(L,1);
Nt = size(L,2);


gx = DegStim/Nx;
gt = ((Nt*DegStim)/Nx)/Nt;




%% smoothing of input (to simulate eye optics)
Age = 20;
glare1=[0:DegStim/size(Stim,1):DegStim/2];
G1 = (10./(glare1.^3)) + ( 1+((Age/62.5)).^4 ).*(5./(glare1.^2));
glare2=[DegStim/size(Stim,1):DegStim/size(Stim,1):DegStim/2-1/(size(Stim,1)/2)];
G2 = (10./(glare2.^3)) + ( 1+((Age/62.5)).^4 ).*(5./(glare2.^2));
PSF = [flip(G1) G2];
glare=[-flip(glare1) glare2];
H=find(glare>-0.01 & glare<0.01);
PSF(H)=PSF(H(1)-1);
%Filter normalization
norm_constant = trapz(PSF); 
PSF = (1/norm_constant)*PSF;  
%%PSF = PSF/(max(PSF));
for i=1:Nt
    L(:,i)=conv(L(:,i),PSF,'same');
end




%% LGN SPATIOTEMPORAL FILTERING
if LGN == 1
    % SPATIAL FILTER
    deg_LGN = DegStim;
    sigma_cen = 0.036;  
    sigma_sur = 0.18;  
    B = 5;
    x = -deg_LGN/2:(deg_LGN/size(Stim,1)):((deg_LGN/2)-(deg_LGN/size(Stim,1)));
    CEN = (1/(2*pi*(sigma_cen^2)))*gaussmf(x,[sigma_cen 0]);
    SUR = (B/(2*pi*(sigma_sur^2)))*gaussmf(x,[sigma_sur 0]);
    DoG = CEN-SUR;


    % TEMPORAL FILTER
    t1 = linspace((1/frStim),100,size(Stim,2));
    k=1;
    n=5;
    T_LGN = (k*t1).^n.*exp(-k*t1).*(1/factorial(n) - (k*t1).^2/factorial(n+2) );



    DoG_st = ones(size(Stim,1),size(Stim,2));
    for i=1:size(Stim,2)
        DoG_st(:,i) = DoG'.*(DoG_st(:,i));
    end   
    for i=1:size(Stim,1)
        DoG_st(i,:) = T_LGN.*(DoG_st(i,:));
    end


    %% IN 1D
    mod_DoG = abs(fftshift(fft(DoG')));
    for i=1:size(Stim,2)
        mod_L = abs(fftshift(fft(L(:,i))));
        ph_L = angle(fftshift(fft(L(:,i))));
        re = fftshift(mod_L.*mod_DoG.*cos(ph_L));
        im = fftshift(mod_L.*mod_DoG.*sin(ph_L));
        re_im = (re+im*sqrt(-1));
        L(:,i) = real(  (ifft(re_im))  ); 
    end


L = (L-(-Nx)) / (Nx-(-Nx));

end



% Normal image size
if (imSize ~= size(Stim,1))
    aaa_s = 1:(Nx-imSize)/2;
    bbb_s = aaa_s(end)+imSize+1:Nx;
    L([aaa_s bbb_s],:) = [];
end
if ((frStim*Secs) ~= size(Stim,2))
    aaa_t = (frStim*Secs)+1;
    bbb_t = size(L,2);
    L(:,[aaa_t:1:bbb_t]) = [];
end


largo_m=round(2*stdm);
centro_m=round(largo_m/2);
r=[1:largo_m];
r=r./largo_m;
m=sin(pi*r);
[mx,ii] = max(m);
std_m = 1;
mean_m = r(ii)*pi;
m1 = gaussmf(pi*r,[std_m mean_m]);
m = m1; %linear term of the model


area_m=sum(sum(m));
m=m./area_m;



mcL=L;
for i=1:frStim*Secs  
    mcL(:,i) = conv(L(:,i),m,'same');
end


Nmin=max(Nm,Nw);




x0 = size(L,1)/2;
for t=1:frStim*Secs 
    TL=0;
    for u=0:Nm-1
        if( (t-u)>=1 )
            TL=TL+Tm(u+1)*mcL(x0,t-u);
        end
    end
    TNL=0;
    for u=0:Nw-1
        TNLx=0;
        ymin=round(max(1,x0-stdw)); 
        ymax=round(min(imSize,x0+stdw)); 

        if( (t-u)>=1 )
            for y=ymin:ymax
                TNLx = TNLx + (1/(2*stdw))*wkernel(y-x0,stdw)*NR(L(y,t-u)-L(x0,t),p,q);
            end
         end
        TNL=TNL+Tw(u+1)*TNLx;
    end
    INRFxt(t)=TL - lambda*TNL;
end

out = INRFxt;
