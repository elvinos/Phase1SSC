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
%  grid on
%   
% end
% 


for G = 0.00:0.05:0.5

sim('TFSimulink.slx',[0 100])


figure(5)
plot(P);
title('P');
hold on;

figure(6)
plot(PD);
title('PD')
hold on;

figure(7)
plot(PID);
title('PID');
hold on;


end
