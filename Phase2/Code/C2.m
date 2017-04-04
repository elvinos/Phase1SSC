close all force;
clear all;
clc;

%% 2nd Order Transfer Function
%tf([1.109],[1 0.1313 1.109])
num= 1.109*180/pi();
den=[1 0.1313 1.109];
A = tf(num,den);
t = 0:0:100;
figure(1)
step(A, t)
%% TF
c = 0;
stepp=0.05;
gg = (0.01:stepp:0.5);
maxgg=max(gg);
Legend=cell(length(gg),1);
   
 for p=1:length(gg)
   Legend{p}=num2str(gg(p));
 end

for G = min(gg):stepp:max(gg)
   
   Kd= G;
   Kp= G;
   Ki= G;
   
 Cp = pid(Kp);
 Tp = feedback(Cp*A,1);
 Cd = pid(Kp,0,Kd);
 Td = feedback(Cd*A,1);
 Ci = pid(Kp,Ki,Kd);
 Ti = feedback(Ci*A,1);

 sp=figure(2);
 step(Tp, t)
 title('P')
 hold on;
 grid on;
 rp=figure(3);
 title('P')
 rlocus(Tp);
 hold on;
 grid on;
 sd=figure(4);
 title('PD')
 step(Td, t)
 hold on;
 grid on;
 rd=figure(5);
 title('PD')
 rlocus(Td);
 hold on;
 grid on;
 si=figure(6);
 title('PID')
 step(Ti, t)
 hold on;
 grid on;
 ri=figure(7);
 title('PID')
 rlocus(Ti);
 hold on;
 grid on;
 
 c= c + 1;
end

%% Legend
for i=2:7
    figure(i)
    legend(Legend)
end
