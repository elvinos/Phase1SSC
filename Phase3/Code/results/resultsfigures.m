%% Clear
clear all
close all
clc

%% Plot
set(0,'DefaultFigureWindowStyle','docked') %% Dock all figures
set(0,'defaultfigurecolor',[1 1 1]) % Set bacground colour to white
set(0,'DefaultAxesFontSize', 16)
set(0,'DefaultTextFontSize', 18)

% finalresult = load('test227','-mat', 'quanser');
origresult = load('test327','-mat', 'quanser');
simimprov = load('simresultsimprov2','-mat', 'simresults');
simorig = load('simresultsorig','-mat', 'simresults');

finalresult = load('finaltest2','-mat', 'quanser');
finalampresp = load('finaltest2','-mat', 'quanser3');

figure()
plot(finalresult.quanser.time,finalresult.quanser.signals.values, 'linewidth', 3)
xlim([35,80])
title('Improved Controller Quanser Reponse')
xlabel('Time/ Seconds')
ylabel('Elevation Angle/ Degrees')

figure()
plot(origresult.quanser.time,origresult.quanser.signals.values, 'linewidth', 3)
title('Original Controller Quanser Reponse')
xlabel('Time/ Seconds')
ylabel('Elevation Angle/ Degrees')


figure()
plot(origresult.quanser.time-20,origresult.quanser.signals.values+2, 'linewidth', 3)
hold on
plot(finalresult.quanser.time,finalresult.quanser.signals.values(:,2), 'linewidth', 3)
xlim([35,80])
grid on
legend('Step Input', 'Orignal Controller', 'Improved Controller')
title('Comparision Between Improved and Original Controller Quanser Response')
xlabel('Time/ Seconds')
ylabel('Elevation Angle/ Degrees')


figure()
plot(finalresult.quanser.time,finalresult.quanser.signals.values(:,1), 'linewidth', 1.5)
hold on
plot(simimprov.simresults.time+35,simimprov.simresults.signals.values(:,2)+23, 'linewidth', 2.5)
plot(finalresult.quanser.time,finalresult.quanser.signals.values(:,2), 'linewidth', 2.5)
xlim([35,80])
legend('Step Input','Simulated Repsonse Improved', 'Quanser Response','Location','southeast')
grid on
title('Comparision of Improved Controller Between Simulated and Quanser Response')
xlabel('Time/ Seconds')
ylabel('Elevation Angle/ Degrees')

figure()
plot(origresult.quanser.time-20,origresult.quanser.signals.values(:,1)+2, 'linewidth', 1.5)
hold on
plot(simorig.simresults.time+35,simorig.simresults.signals.values(:,2)+23, 'linewidth', 2.5)
plot(origresult.quanser.time-20,origresult.quanser.signals.values(:,2)+2, 'linewidth', 2.5)
xlim([35,80])
legend('Step Input','Simulated Repsonse Original', 'Quanser Response','Location','southeast')
grid on
title('Comparision of Original Controller between Simulated and Quanser Response')
xlabel('Time/ Seconds')
ylabel('Elevation Angle/ Degrees')

figure()
plot(finalresult.quanser.time,finalresult.quanser.signals.values(:,1), 'linewidth', 1.5)
hold on
plot(simimprov.simresults.time+35,simimprov.simresults.signals.values(:,2)+23, 'linewidth', 2.5)
plot(finalresult.quanser.time,finalresult.quanser.signals.values(:,2), 'linewidth', 2.5)
xlim([35,80])
ylim([22.5,25.5])
legend('Step Input','Simulated Repsonse Improved', 'Quanser Response','Location','southeast')
grid on
title('Comparision of Improved Controller Between Simulated and Quanser Response')
xlabel('Time/ Seconds')
ylabel('Elevation Angle/ Degrees')

figure()
plot(simimprov.simresults.time+35,(simimprov.simresults.signals.values(:,2))*100/2-100, 'linewidth', 2.5)
hold on
plot(finalresult.quanser.time,(finalresult.quanser.signals.values(:,2)-23)*100/2-100, 'linewidth', 2.5)
xlim([40,80])
ylim([-10,10])
legend('Simulated Repsonse', 'Quanser Response','Location','southeast')
grid on
title('Percentage Error Comparision of Improved Controller Between Simulated and Quanser Response')
xlabel('Time/ Seconds')
ylabel('Percentage Error / %')

figure()
plot(simorig.simresults.time+35,(simorig.simresults.signals.values(:,2))*100/2-100, 'linewidth', 2.5)
hold on
plot(origresult.quanser.time-20,(origresult.quanser.signals.values(:,2)-21)*100/2-100, 'linewidth', 2.5)
xlim([40,80])
ylim([-50,30])
legend('Simulated Repsonse', 'Quanser Response','Location','southeast')
grid on
title('Percentage Error Comparision of Original Controller Between Simulated and Quanser Response')
xlabel('Time/ Seconds')
ylabel('Percentage Error / %')
figure()
plot(finalampresp.quanser3.time,(finalampresp.quanser3.signals.values), 'linewidth', 1.5)
grid on
title('Rate of Quanser Response')
xlabel('Time/ Seconds')
ylabel('Magnitude of Rate Response')