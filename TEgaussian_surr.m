function [gc_red_surr,gc_syn_surr]=TEgaussian_surr(x,p,drivers_red,drivers_syn,nsurr,kmax)
%i -> j
for dr=3:kmax+2
    xx=x(:,drivers_red(1:dr-1));
    for k=1:nsurr
        ys=surr_iaafft(x(:,drivers_red(dr)));
        xxx=xx;xx(:,dr)=ys;
        gc=TE_gaussian(xxx,p,1,2);
        Gs=mean(gc);
        gc_red_surr(k,dr)=Gs;
    end
end
for dr=3:kmax+2
    xx=x(:,drivers_syn(1:dr-1));
    for k=1:nsurr
        ys=surr_iaafft(x(:,drivers_syn(dr)));
        xxx=xx;xx(:,dr)=ys;
        gc=TE_gaussian(xxx,p,1,2);
        Gs=mean(gc);
        gc_syn_surr(k,dr)=Gs;
    end
end
