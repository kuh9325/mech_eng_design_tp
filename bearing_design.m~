function bearing_design(c0, e)
%% initial setting %%
Fr = [140 120 100 121]; % radial load
t = [0.02 0.06 0.02 0.9]; % time fraction
n = [1123 1123 1123 561.5]; % angular speed
Fa = [1 1 1 1]; % axial load
af = 1.2;

ld = 30000; % desired life
nd = 818; % desired rpm

xd = (60*ld*nd)/(10^6);
x0 = 0.02;
th = 4.439;
Rd = sqrt(0.99);
a = 10/3;
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
P = zeros(1,4);
for i=1:4
    Fe(i) = Xi(i)*V*Fr(i) + Yi(i)*Fa(i);
    P(i) = t(i)*n(i); % product of t and n 
end

Tf = zeros(1,4);
numF = zeros(1,4);
denF = zeros(1,4);
for i=1:4
    Tf(i) = P(i)/sum(P);
    numF(i) = n(i)*t(i)*((af*Fe(i)^3)); % for ball bearing
    denF(i) = n(i)*t(i);
end

Feq = (sum(numF)/sum(denF))^(1/3); % equivalent load

C1 = Feq*(xd/(x0+(th-x0)*((log(1/Rd))^(1/b))))^(1/a);

fprintf('\n처음 계산된 C1 : %.3f\n\n', C1)

%% iteration until it converges %%

sol = zeros(1,4);
for i=1:4
    sol(i) = Fa(i)/c0;
    fprintf('%d번째 Fa/c0 : %.3f\n', i,sol(i))
end
fprintf('\n')
ar = zeros(1,4);
for i=1:4
    ar(i) = Fa(i)/(V*Fr(i));
    fprintf('%d번째 Fa/(VFr) : %.3f\n', i,sol(i))
end

Xi = zeros(1,4);
Yi = zeros(1,4);
for i=1:4
    if sol(i)<0.014
        sol(i) = 0.014;
    end
    if ar(i) <= e
        Xi(i) = 1;
        Yi(i) = 0;
    else
        Xi(i) = 0.56;
        if e == 0.19;        Yi(i) = 2.3;
        elseif e == 0.21;    Yi(i) = 2.15;
        elseif e == 0.22;    Yi(i) = 1.99;
        elseif e == 0.24;    Yi(i) = 1.85;
        elseif e == 0.26;    Yi(i) = 1.71;
        elseif e == 0.27;    Yi(i) = 1.63;
        elseif e == 0.28;    Yi(i) = 1.55;
        elseif e == 0.30;    Yi(i) = 1.45;
        elseif e == 0.34;    Yi(i) = 1.31;
        elseif e == 0.38;    Yi(i) = 1.15;
        elseif e == 0.42;    Yi(i) = 1.04;
        elseif e == 0.44;    Yi(i) = 1;
        end
    end     
end

end

