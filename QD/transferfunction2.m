%% Clear
clc
clear all
close all
%% Means

meanelev = meanelev();
elevaverage = 26.216810576567050;
elevaverage1 = 11.8187012933157;
k = (elevaverage-elevaverage1)/4;
krad = k*pi()/180;

%% Transfer Function Variables

offsetdeg = elevaverage;
offsetrad = offsetdeg*pi()/180;

nperiod= 4;
T = (-42.98+61.2)/nperiod;
wn = 2*pi()/T;
logdec = (1/nperiod)*log((39.22 - offsetdeg) /(29.99 - offsetdeg));
zeta = logdec/(2*pi());
wd = wn*sqrt(1-(zeta^2));
sigma = zeta*wn;
top = wn^2;

%% Transfer Function

opt = stepDataOptions('InputOffset',0,'StepAmplitude',0.238);
sys = tf([top],[1 zeta*2*wn top]);
[yyrad, tt] = step(sys,opt);
yydeg = yyrad*180/pi();

% figure(1);5
% plot(tt,yydeg);

yyaveragedeg = mean([yydeg]);
yyaveragerad = mean([yyrad]);
yyred = yydeg(1:177);
ttred = tt(1:177);
% Change between deg and rad
figure(2)

plot(ttred,yyred+offsetdeg-yyaveragedeg+1.25);
hold on
elev40 = meanelev(:,3);
elev40 = elev40(39860:79851);
tp = 40/(79851-39860);
time = 0:tp:40;
% plot(elev3time,meanelev(:,3));
plot(time,elev40);
% plot([0 elevaverage], [time(end) elevaverage]);

%% Underdamped Y plot
% i = 0;
% for t = 0:0.001:40
%     i = i+1;
% y(i)= 1-exp(-sigma*t)*cos(wd*t)-(zeta/sqrt(1-zeta^2))*exp(-sigma*t)*sin(wd*t);
% end
%  y = y';
%  yaverage = mean([y]);
%  t = 0:0.001:40;
%  plot(t,y+offsetdeg-yaverage);
%  hold on
% % plot(elev3time,meanelev(:,3));
%  plot(time,elev40);
