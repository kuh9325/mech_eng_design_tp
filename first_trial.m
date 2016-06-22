%% initial setting %%
Fr = [140 120 100 121]; % radial load (kN)
t = [0.02 0.06 0.02 0.9]; % time fraction
n = [1123 1123 1123 561.5]; % angular speed (RPM)
Fa = [1 1 1 1]; % axial load (kN)
af = 1.5;

ld = 30000; % desired life
nd = 818; % desired rpm

xd = (60*ld*nd)/(10^6);
x0 = 0.02;
th = 4.439;
Rd = sqrt(0.99);
a = 3; % for roller bearing (ball bearing : 3)
b = 1.483;

%% first trial (assume that Fa/VFr > e) %%
Xi = zeros(1,4);
Yi = zeros(1,4);
for i=1:4
    Xi(i) = 0.56;
    Yi(i) = 1.63;
end
V = 1.2;

Fe = zeros(1,4);
Pc = zeros(1,4);
for i=1:4
    Fe(i) = Xi(i)*V*Fr(i) + Yi(i)*Fa(i);
    Pc(i) = t(i)*n(i); % product of t and n 
end

Tf = zeros(1,4); % turns fraction
numF = zeros(1,4);
denF = zeros(1,4);
for i=1:4
    Tf(i) = Pc(i)/sum(Pc);
    numF(i) = n(i)*t(i)*((af*Fe(i))^a); % be aware of 'a'
    denF(i) = n(i)*t(i);
end

Feq = (sum(numF)/sum(denF))^(1/a); % equivalent load

C1 = Feq*(xd/(x0+(th-x0)*((log(1/Rd))^(1/b))))^(1/a);

fprintf('\n처음 계산된 C1 : %.3fkN\n\n', C1)