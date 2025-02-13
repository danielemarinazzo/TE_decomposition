function [drivers_red,drivers_syn,g_red,g_syn,gc_red_surr,gc_syn_surr]=...
    TEgaussian_surr(x,i_driver,i_target,model_order,nsurr,kmax)
[drivers_red,drivers_syn,g_red,g_syn]=TE_syn_red(x,i_driver,i_target,model_order);
g_red=[0 g_red];
g_syn=[0 g_syn];
for dr=3:kmax+2
    xx=x(:,drivers_red(1:dr-1));
    for k=1:nsurr
        ys=surr_iaafft(x(:,drivers_red(dr)));
        xxx=xx;xx(:,dr)=ys;
        gc=TE_gaussian(xxx,model_order,1,2);
        Gs=mean(gc);
        gc_red_surr(k,dr)=Gs;
    end
    if g_red(dr)>prctile(gc_red_surr(:,dr),5)
        g_red(dr+1:end)=[];
        break
    end
end
for dr=3:kmax+2
    xx=x(:,drivers_syn(1:dr-1));
    for k=1:nsurr
        ys=surr_iaafft(x(:,drivers_syn(dr)));
        xxx=xx;xx(:,dr)=ys;
        gc=TE_gaussian(xxx,model_order,1,2);
        Gs=mean(gc);
        gc_syn_surr(k,dr)=Gs;
    end
    if g_syn(dr)<prctile(gc_syn_surr(:,dr),95)
        g_syn(dr+1:end)=[];
        break
    end
end
