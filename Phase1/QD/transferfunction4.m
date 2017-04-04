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
wd = 2*pi()/T;
logdec = (1/nperiod)*log((39.22 - offsetdeg) /(29.99 - offsetdeg));
zeta = logdec/(2*pi());
wn = wd/sqrt(1-(zeta^2));
sigma = zeta*wn;
top = wn^2;

%% Transfer Function


sys = tf([(top-0.79)*0.26],[1 (zeta-0.01)*2*wn top-0.79]); %0.01
%sys = tf([(top)],[1 (zeta)*2*wn top]); %0.01

[yyrad, tt] = step(sys);
yydeg = yyrad*180/pi();

% figure(1);5
% plot(tt,yydeg);

yyaveragedeg = mean([yydeg]);
yyaveragerad = mean([yyrad]);
yyred = yydeg(1:177);
ttred = tt(1:177);
% Change between deg and rad
figure(2)

plot(ttred,yyred+offsetdeg-yyaveragedeg);
hold on
elev40 = meanelev(:,3);
elev40 = elev40(39860:79851);
tp = 40/(79851-39860);
time = 0:tp:40;
% plot(elev3time,meanelev(:,3));
plot(time,elev40);
% plot([0 elevaverage], [time(end) elevaverage]);

%%First order response

tau = 1/(zeta*wn)-1;


%t=0:tau:20*tau;
%plot(t, yn,'b');
% fo = tf([1]*0.21,[tau 1]);
% [mm rr] = step(fo);
% mmdeg = mm*(180/pi());
% mmdegshift = mmdeg;
%plot(rr, mmdegshift+14.48606);

fo = tf([(top)*0.25],[(1)*2*wn top])

[mm rr] = step(fo);
mmdeg = mm*(180/pi());
mmdegshift = mmdeg+12-0.1032;

mmdegshift(197,1) = 26.2168;
rr(197,1) = 50;  
plot(rr, mmdegshift);
xlim([0,40])
figure,
hold on
pzmap(fo);
pzmap(sys);
grid on;
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


