%% Clear

clc
clear all
close all

%% Data Aggregate
for n=0:3 
    m=n+1;
load(['m2' num2str(n) '1.mat'],'elevData');
elev1 = elevData;
load(['m2' num2str(n) '2.mat'],'elevData');
elev2 = elevData;
load(['m2' num2str(n) '3.mat'],'elevData');
elev3 = elevData;
elev1sig = elev1.signals.values(1:79851);
elev2sig = elev2.signals.values(1:79851);
elev3sig = elev3.signals.values(1:79851);
elev3time = elev3.time(1:79851);
elev4 = mean([elev1sig elev2sig elev3sig],2);
meanelev(:,m) = elev4;
elev3timeav = elev3time(39860:79851);
elev4av = elev4(39860:79851);
elevendmean(:,m)= elev4av;
elev5av = elev4(1:39860);
elevaverage(m) = mean([elev4av]);
figure(1)
plot(elev3time,meanelev(:,m))
hold on;
end 
title('Plot of Experimental Quanser Responses for a Range of Step Inputs')
xlabel('Time');
ylabel('Elevation Angle');
legend('-2,0','-2,1','-2,2','-2,-1');

for m=1:4
figure(2);
plot(elev3timeav, elevendmean(:,m))
hold on
end
title('Comparision of Quanser Repsonses against Aggregated Transfer Fucntions Varying in Gain')
xlabel('Time');
ylabel('Elevation Angle');

%% Variables

wnadj=0.12;
zetaadj=0.006;
kmax = 0.26;
grad = 3.533;
c = 5.4011;
kdivide = (grad*2+c)./kmax;
num = [4 1 2 3];

for m=1:4
n = num(m);
k(n) = (grad*(m-2)+c)/kdivide;
end

xyval= [23.9200000000000,30.4000000000000,39.2200000000000,17.4500000000000;20.1100000000000,24.7200000000000,29.9900000000000,15.8100000000000;42.9100000000000,42.9100000000000,42.9800000000000,42.4000000000000;64.9000000000000,65.7950000000000,61.2000000000000,66];
nperiod= 4;


%% Find 4 Transfer Functions
for m=1:4
    
% 2nd Order Function
offsetdeg(m) = elevaverage(m);
offsetrad = offsetdeg(m)*pi()/180;
T(m) = (xyval(4,m)-xyval(3,m))/nperiod;
wd(m) = 2*pi()/T(m);
logdec(m) = (1/nperiod)*log((xyval(1,m) - offsetdeg(m)) /(xyval(2,m) - offsetdeg(m)));
zeta(m) = logdec(m)./(2*pi()) + zetaadj;
wn(m) = wd(m)/sqrt(1-(zeta(m)^2));
sigma(m) = zeta(m)*wn(m);
top(m) = (wn(m)-wnadj)^2;
sys(m) = tf([(top(m))*k(m)],[1 (zeta(m))*2*wn(m) top(m)]);
[yyrad, tt] = step(sys(m));
yydeg = yyrad.*180/pi();
yyred(:,m) = yydeg(1:177);
yyaveragedeg(m) = mean([yydeg]);
ttred(:,m) = tt(1:177)+40;
yoffset(m) = offsetdeg(m)-yyaveragedeg(m);
% figure(2)
% plot(ttred(:,m),yyred(:,m)+yoffset(m),'*');
% hold on

% 1st Order Function
fo(m) = tf([(top(m)*k(m))],[(1)*2*wn(m) top(m)]);

[mm rr] = step(fo(m));
mmdeg = mm*(180/pi());
mmdegshift = mmdeg+yoffset(m);
mmdegshift(197,1) = offsetdeg(m);

rr(197,1) = 50;
fott(:,m)=rr;
foy(:,m)=mmdegshift;
% figure(3)
% plot(rr, mmdegshift);
% xlim([0,40]) 
% hold on
end
% legend('m20','m21','m22','m2m1','tfm20','tfm21','tfm22','tfm2m1');

%% Mean TF

offsetdegmean = mean([offsetdeg(m)]);
tmean= mean([T]);
wdmean= mean([wd]);
logdecmean= mean([logdec]);
zetamean= mean([zeta])+zetaadj;
wnmean = mean([wn])-wnadj;
sigmamean = mean([sigma]);

%Mean Transfer Fucntion
sysTF2= tf([(wnmean^2)],[1 (zetamean)*2*wnmean wnmean^2])
sysTF1= tf([(wnmean^2)],[2*wnmean wnmean^2])

% Loop to find scaled transfer fucntions for different steps
for m= 1:4
%2nd Order  
sysmean(m) = tf([(wnmean^2)*k(m)],[1 (zetamean)*2*wnmean wnmean^2]);
[yyradmean, ttmean] = step(sysmean(m));
yydegmean = yyradmean.*180/pi();
yyredmean(:,m) = yydegmean(1:135);
yyaveragedegmean = mean([yyaveragedeg]);
ttredmean(:,m) = ttmean(1:135)+40;
yoffsetmean(m) = mean([yoffset]);
figure(2)
plot(ttredmean(:,m),yyredmean(:,m)+yoffsetmean(m),'--');
hold on
% First Order
fomean(m) = tf([(wnmean^2)*k(m)],[2*wnmean wnmean^2]);

[mmmean rrmean] = step(fomean(m));
mmdegmean = mmmean*(180/pi());
mmdegshiftmean = mmdegmean+yoffsetmean(m);
mmdegshiftmean(197,1) = max(mmdegshiftmean);

rrmean(197,1) = 50;
fottmean(:,m)=rr+40;
foymean(:,m)=mmdegshiftmean;

plot(fottmean(:,m), foymean(:,m));
 
hold on

end
figure(2)
legend('m20','m21','m22','m2m1','2tfm20','2tfm21','2tfm22','2tfm2m1','1tfm20','1tfm21','1tfm22','1tfm2m1');
xlim([40,80])
figure,
pzmap(sysTF1);
hold on

pzmap(sysTF2);
grid on;

% figure(4)
% legend('m20','m21','m22','m2m1')

%% Graph Plot

for m=1:4
figure(4);
plot(elev3timeav, elevendmean(:,m),'--','LineWidth', 1)
hold on
plot(ttredmean(:,m),yyredmean(:,m)+yoffsetmean(m),'LineWidth', 1.5);
hold on
figure(5)
plot(elev3timeav, elevendmean(:,m),'--','LineWidth', 1)
hold on
plot(fottmean(:,m), foymean(:,m),'LineWidth', 1.5);
hold on
end

% figure(5)
% plot(fottmean(:,1), foymean(:,1));
% hold on
% plot(fottmean(:,3), foymean(:,3));
% hold on
figure(4)
xlim([40,80])
title({'Comparision of Experimental Quanser Repsonses Against', 'Simulated Transfer Fucntion Varying Gain - 2nd Order'})
xlabel('Time (Seconds)');
ylabel('Elevation Angle (Degrees)');
legend('Exp:-2,0', 'Sim:-2,0','Exp:-2,1', 'Sim:-2,1','Exp:-2,2','Sim:-2,2','Exp:-2,-1','Sim:-2,-1');

figure(5)
xlim([40,80])
title({'Comparision of Experimental Quanser Repsonses Against', 'Simulated Transfer Fucntion Varying Gain - 1st Order'})
xlabel('Time (Seconds)');
ylabel('Elevation Angle (Degrees)');
legend('Exp:-2,0', 'Sim:-2,0','Exp:-2,1', 'Sim:-2,1','Exp:-2,2','Sim:-2,2','Exp:-2,-1','Sim:-2,-1');

figure(1)
hold on
x= [mean([elev5av]),mean([elev5av])];
tx=[0,80];
plot(tx, x,'k--')
