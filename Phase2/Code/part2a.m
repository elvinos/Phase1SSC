close all force;
clear all;
clc;

%% 2nd Order Transfer Function
%tf([1.109],[1 0.1313 1.109])
%-2 to 2, 0.26

%including our observed k from previous task and degree converter
num=[0.26*1.109*180/pi()];
den=[1 0.1313 1.109];
A = tf(num,den);
t = 0:0:100;

set(0,'DefaultFigureWindowStyle','docked') %% Dock all figures
set(0,'defaultfigurecolor',[1 1 1]) % Set bacground colour to white
set(0,'DefaultAxesFontSize', 16)
set(0,'DefaultTextFontSize', 18)

%% Gain iterating

% stepP=0.1;
stepP=0.005;
Gg = (0:stepP:0.1);
maxGg=max(Gg);
minGg=min(Gg);

Legend=cell(length(Gg),1);
   
for p=1:length(Gg)
    Legend{p}=num2str(Gg(p));
end

j = 1;
for G = minGg:stepP:maxGg

   Kd= G;
   Kp= G;
   Ki= G;
sim('PIDp2.slx',[0 20])
   
         Cpid = pid(Kd,Ki,Ki);
         Tpid = feedback(Cpid*A,1);
         stepinfoKPID(j) = stepinfo(Tpid,'SettlingTimeThreshold',0.04);

        figure(72)
        plot(varyKIKDKP);
        title('Response For PID');
        hold on;
        figure(73)
        pzmap(Tpid);
        title('Root Locus for PID')
        grid on;
        hold on;
         
        j = j + 1;
        
end

Effect_of_Varying_KPID = struct2table(stepinfoKPID);
Gain= Gg';
gaintab = table(Gain);

ResultsTable=[gaintab,Effect_of_Varying_KPID];


for i=72:73
    figure(i)
    
    if i < 73
        xlabel('Time/ Seconds')
        ylabel('Response')
       legend(Legend,'Orientation','vertical','Location','southeast')

    else
        legend(Legend,'Orientation','vertical','Location','northwest')
    end
end 
