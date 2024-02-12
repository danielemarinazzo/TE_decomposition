clear;clc;
%toy model
x=randn(1000,4);
for t=2:1000;x(t,4)=0.9*x(t-1,3)+0.1*x(t,4);x(t,3)=0.5*x(t-1,1)+0.5*x(t-1,2)+0.1*x(t,3);end
i_driver=1;i_target=4;
model_order=2;
[drivers_red,drivers_syn,g_red,g_syn]=TE_syn_red(x,i_driver,i_target,model_order);
%%surrogates
nsurr=10;
kmax=2; % maximum number of variables to condition to
[g_red_surr,g_syn_surr]=TEgaussian_surr(x,model_order,drivers_red,drivers_syn,nsurr,kmax);
figure(1)
plot(g_red,'-*k');hold on
plot(2:kmax+1,g_red_surr(:,3:kmax+2),'-or');
figure(2)
plot(g_syn,'-*k');hold on
plot(2:kmax+1,g_syn_surr(:,3:kmax+2),'-or');