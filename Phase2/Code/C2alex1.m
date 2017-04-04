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


for G = 0.01:0.05:0.5
   Kd= G;
   Kp= G;
   Ki= G;
   
 Cp = pid(G);
 Tp = feedback(Cp*A,1);
 Cd = pid(G,0,G);
 Td = feedback(Cd*A,1);
 Ci = pid(G,G,G);
 Ti = feedback(Ci*A,1);

 figure(4)
 step(Tp, t)
 hold on;
 grid on;
 figure(5)
 rlocus(Tp);
 hold on;
 grid on;
  figure(6)
 step(Td, t)
 hold on;
 grid on;
 figure(7)
 rlocus(Td);
 hold on;
 grid on;
  figure(8)
 step(Ti, t)
 hold on;
 grid on;
 figure(9)
 rlocus(Ti);
 hold on;
 grid on;
 
end
