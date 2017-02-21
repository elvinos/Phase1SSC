function [meanelev]= meanelev()
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
elev5av = elev4(1:39860);
elevaverage(m) = mean([elev4av]);
elevaverage1(m) = mean([elev5av]);
end 

end
