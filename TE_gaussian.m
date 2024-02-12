function te=TE_gaussian(x,p,i,j)
% x data S (samples) x n (variables) dati 
% i driver j target
% p order of the model
[NS, n]=size(x);
ind=setdiff(1:n,[i j]);
NS_p=NS-p;
y=zeros(NS_p,1);
Y=zeros(NS_p,p);
X=zeros(NS_p,p);
Z=zeros(NS_p,p*(n-2));
y=x(p+1:NS,j);
for h=1:p
Y(:,h)=x(h:NS_p+h-1,j);
X(:,h)=x(h:NS_p+h-1,i);
for m=1:n-2
    Z(:,(n-2)*(h-1)+m)=x(h:NS_p+h-1,ind(m));
end
end
[~,~,R] = regress(y,[Y Z]);v=var(R);
[~,~,R] = regress(y,[Y X Z]);v1=var(R);
te=.5*log(v/v1);