function [drivers_red,drivers_syn,g_red,g_syn]=TE_syn_red(x,i,j,p)
%transfer entropy i -> j 
%p=order of the model
xxx=size(x);
TE=TE_gaussian(x(:,[i j]),p,1,2);
g=mean(TE);
g_red(1)=g;g_syn(1)=g;

drivers_red=[i j];
ind=setdiff(1:xxx(2),[i j]);
m=length(ind);
icont=1;
while m > 0
    icont=icont+1;
    for h=1:m
        dt=[drivers_red ind(h)];
        TE=TE_gaussian(x(:,dt),p,1,2);
        TE_mean=mean(TE);
        deltas(h)=TE_mean;
    end
    [g_red(icont), ii]=min(deltas);
    drivers_red=[drivers_red ind(ii)];
    ind=setdiff(ind,ind(ii));m=length(ind);
    clear deltas;
end
%%%%
drivers_syn=[i j];
ind=setdiff(1:xxx(2),[i j]);
n=length(drivers_syn);
m=length(ind);
icont=1;
while m > 0
    icont=icont+1;
    for h=1:m
        dt=[drivers_syn ind(h)];
        TE=TE_gaussian(x(:,dt),p,1,2);
        TE_mean=mean(TE);
        deltas(h)=TE_mean;
    end
    [g_syn(icont), ii]=max(deltas);
    drivers_syn=[drivers_syn ind(ii)];
    ind=setdiff(ind,ind(ii));m=length(ind);
    clear deltas;
end
