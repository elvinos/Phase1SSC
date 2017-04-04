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

%% Part 1a
% for Kp = 0:0.01:0.1
%     
%  C = pid(Kp)
%  T = feedback(C*A,1)
% 
%  figure(2)
%  step(T, t)
%  hold all;
%  grid on;
%  figure(3)
%  rlocus(T);
%  hold all;
%  grid on;
%  
% end
% 
% %% Part 1b
% Kp = 0.05;
% 
% for Kd = 0:0.05:0.5
%     
%  C = pid(Kp, 0 , Kd)
%  T = feedback(C*A,1)
% 
%  figure(4)
%  step(T, t)
%  hold all;
%  grid on;
%  figure(5)
%  rlocus(T);
%  hold all;
%  grid on;
%  
% end
% 

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

 sp=figure(4);
 step(Tp, t)
 title('P')
 hold on;
 grid on;
 rp=figure(5);
 title('P')
 rlocus(Tp);
 hold on;
 grid on;
 sd=figure(6);
 title('PD')
 step(Td, t)
 hold on;
 grid on;
 rd=figure(7);
 title('PD')
 rlocus(Td);
 hold on;
 grid on;
 si=figure(8);
 title('PID')
 step(Ti, t)
 hold on;
 grid on;
 ri=figure(9);
 title('PID')
 rlocus(Ti);
 hold on;
 grid on;
 
 c= c + 1;
end

%% Legend

for i=4:9
    figure(i)
    legend(Legend)
end
