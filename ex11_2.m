a=4.439;
b=1.483;
x=0:0.1:20;
f=wblpdf(x,a,b);
plot(x,f);
grid on
f1=b/a*(x/a).^(b-1).*exp( -(x/a).^b );
hold on;
plot(x,f1, 'r ');
x10 = wblinv(0.1,a,b) % this is B10 life.
hold on;
plot(x10,0,'s','MarkerFaceColor','r');
plot([x10 x10], [0 wblpdf(x10,a,b)],'r');
x50 = wblinv(0.5,a,b) % median
plot(x50,0,'s','MarkerFaceColor','m');
xmean=a*gamma(1+1/b);
plot(xmean,0,'s','MarkerFaceColor','g'); % mean close