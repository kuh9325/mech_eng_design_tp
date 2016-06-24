%% initial setting %%
% taxi before take off, take off, landing, taxi after landing 
Fr = [996.924 906.999 558.834 339.975]; % radial load (N)
t = [(20/40) (10/40) (10/40) (20/40)]; % time fraction
n = [27.849 661.823 639.544 27.849]; % angular speed (RPM)
af = 1.5;
v = length(Fr); % number of variable loading

ld = 30000; % desired life (hour)
nd = 670; % desired rpm (maximum)

xd = (60*ld*nd)/(10^6);
x0 = 0.02;
th = 4.439;
Rd = sqrt(0.99);
a = 10/3; % for roller bearing (ball bearing : 3)
b = 1.483;

%% calculation

Pc = zeros(1,v);
for i=1:4
    Pc(i) = t(i)*n(i); % product of t and n 
end

Tf = zeros(1,v); % turns fraction
numF = zeros(1,v);
denF = zeros(1,v);
for i=1:v
    Tf(i) = Pc(i)/sum(Pc);
    numF(i) = n(i)*t(i)*((af*Fr(i))^a); % be aware of 'a'
    denF(i) = n(i)*t(i);
end

Feq = (sum(numF)/sum(denF))^(1/a); % equivalent load

C1 = Feq*(xd/(x0+(th-x0)*((log(1/Rd))^(1/b))))^(1/a);

fprintf('\n°è»êµÈ C1 : %.3fN\n\n', C1)