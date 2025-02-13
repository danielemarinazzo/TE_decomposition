clear;clc;
%toy model
x=randn(1000,4);
for t=2:1000;x(t,4)=0.9*x(t-1,3)+0.1*x(t,4);x(t,3)=0.5*x(t-1,1)+0.5*x(t-1,2)+0.1*x(t,3);end
model_order=2;
nsurr=100;
i_driver=1;i_target=4;
kmax=2; % maximum number of variables to condition to
[drivers_red,drivers_syn,g_red,g_syn]=TE_syn_red(x,i_driver,i_target,model_order);
[drivers_red,drivers_syn,g_red,g_syn,g_red_surr,g_syn_surr]=TEgaussian_surr(x,i_driver,i_target,model_order,nsurr,kmax);
Tm=g_red(end);
TM=g_syn(end);
if g_red(end)>prctile(g_red_surr(:,end),95)
    Tm=g_red(end-1);
end
if g_syn(end)<prctile(g_syn_surr(:,end),5)
    TM=g_syn(end-1);
end
perc_HO=(TM-Tm)/TM;
ratio_HO=(TM-Tm)/Tm;
%%
figure
subplot(2,1,1)
plot(2:length(g_red),g_red(2:end),'ok','MarkerFaceColor','k');hold on
plot(3:size(g_red_surr,2),g_red_surr(:,3:end),'or');
if g_red(end)>prctile(g_red_surr(:,end),95)
    plot(length(g_red),g_red(end),'xr','MarkerSize',20);
end
xlim([1.8 size(g_red_surr,2)+.1]);xticks(2:length(g_red)+1)
set(gca, 'XTickLabel', string(drivers_red(2:length(g_red))), 'FontSize',16)
ylabel('Tm (redundancy)')
subplot(2,1,2)
plot(2:length(g_syn),g_syn(2:end),'ok','MarkerFaceColor','k');hold on
plot(3:size(g_syn_surr,2),g_syn_surr(:,3:end),'or');
if g_syn(end)<prctile(g_syn_surr(:,end),5)
    plot(length(g_syn),g_syn(end),'xr','MarkerSize',20);
end
xlim([1.8 size(g_syn_surr,2)+.1]);xticks(2:length(g_syn)+1)
set(gca, 'XTickLabel', string(drivers_syn(2:length(g_syn))), 'FontSize',16)
ylabel('TM (synergy)')
suptitle({['driver ' num2str(i_driver) ', target ' num2str(i_target)],...
    ['percentage HOI = ', num2str(100*perc_HO,'%.2f'), ', ratio HOI/PW = ', num2str(ratio_HO,'%.2f')]})
