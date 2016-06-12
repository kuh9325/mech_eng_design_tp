% 10,000 numbers of bearing life data for 10 years:
% 1.5243 0.9330 7.2352 0.8792 2.6230 ...
a=4.439;
b=1.483;
X=wblrnd(a,b,1e4,1);
hist(X,10)
hist(X,50)
x=0:0.1:20;
f=wblpdf(x,a,b);
plot(x,f);
grid on
f1=b/a*(x/a).^(b-1).*exp( -(x/a).^b );
hold on;
plot(x,f1, 'r ');
% trends of distribution in terms of parameters
clear f;
for i=1:5;
    f(:,i)=wblpdf(x,a,2*i);
end;
plot(x,f);
legend('1','2','3','4','5')
clear f;
for i=1:5;
    f(:,i)=wblpdf(x,2*i,b);
end;
plot(x,f)
legend('1','2','3','4','5')