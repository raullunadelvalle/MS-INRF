clear all
close all
clc



%% SPATIO-TEMPORAL FREQUENCY SELECTIVITY

% Stimulus parameters
dir = -1;
s_frec = linspace(0,10,100); 
t_frec = linspace(0,30,100); 
s_frec_fixed = 8.5;
t_frec_fixed = 1;
ctr = 0.4; 
%phase range%%%
nPH_variable = 10; 
ph_variable = linspace(-pi,pi,nPH_variable); 
nPH_fixed = 10; 
ph_fixed = linspace(-pi,pi,nPH_variable); 
%%%%%%%%%%%%%%%
angle = 0;

DegStim = 2;
imSize = 400;

Secs = 1;
fr = 120;


% INRF parameters
stdw = [0.125];
Nw = [0.05]; 
lambda = -30;
p = 0.4; 
q = 0.1; 

LGN = 0;


tic

out_stdwNw_tFrec = cell(length(Nw),length(stdw));
out_stdwNw_tFrec = cellfun(@(x) zeros(length(t_frec),length(s_frec)),out_stdwNw_tFrec,'UniformOutput',false);


a_Nw = 0;

tic

    for aa = 1:length(Nw)
    for bb = 1:length(stdw)
    
        out_tFrec = zeros(length(t_frec),length(s_frec));
        out_tFrec_allPhases = zeros(length(t_frec),length(s_frec));
        
        for mm = 1:length(ph_fixed)
            mm
            phase_fixed = ph_fixed(mm);
            for nn = 1:length(ph_variable)
                nn
                phase_variable = ph_variable(nn);
        
                out_tFrec1 = zeros(length(t_frec),length(s_frec));
                for i = 1:length(t_frec)
                for j = 1:length(s_frec)
                    L_tFrec = moving_sinewave_complex_tempFrec(dir,s_frec(j),t_frec(i),s_frec_fixed,t_frec_fixed,ctr,phase_variable,phase_fixed,angle, DegStim,imSize,Secs,fr);
                    out_tFrec1(i,j) = mean( INRF_motion(L_tFrec,DegStim,imSize,fr,Secs, stdw(bb),Nw(aa),lambda,p,q, LGN) );
                end
                end
                out_tFrec = (out_tFrec+out_tFrec1);
            end
            out_tFrec_allPhases = (out_tFrec_allPhases + out_tFrec);  
        end

        out_stdwNw_tFrec{aa,bb} = out_tFrec_allPhases / (nn*mm);

    end
    end

toc



cd 'SpatioTemporal_maps'

save('SpatioTemporal_map_complex.mat', 'out_stdwNw_tFrec', 'dir','s_frec','s_frec_fixed','t_frec','t_frec_fixed','ctr','ph_fixed','ph_variable','angle','DegStim','imSize','Secs','fr',...
    'Nw','stdw','lambda','p','q')   


