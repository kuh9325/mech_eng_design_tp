function bearing_design(c0,type,in_out)
%% initial setting %%
Fr = [140 120 100 121]; % radial load (kN)
t = [0.02 0.06 0.02 0.9]; % time fraction
n = [1123 1123 1123 561.5]; % angular speed (RPM)
Fa = [1 1 1 1]; % axial load (kN)
af = 1.5;

ld = 30000; % desired life (cycle)
nd = 818; % desired rpm

xd = (60*ld*nd)/(10^6);
x0 = 0.02;
th = 4.439;
Rd = sqrt(0.99);
if type == ball
    a = 3; % for roller bearing
elseif type == roller
    a = 10/3; % for ball bearing
end
b = 1.483;
if in_out == inner
    V = 1; % for inner ring rotates
elseif in_out ==outer
    V = 1.2; % for outer ring rotates
end
C1 = 0; % initial setting for loop

%% iteration until it converges %%

% preallocation of matrix %
fc = zeros(1,4); % fc = Fa/C0_r;
e = zeros(1,4);
Xi = zeros(1,4);
Yi = zeros(1,4);
fafr = zeros(1,4); % Fa/VFr
Fe = zeros(1,4); % equivalent load
Pc = zeros(1,4); % product of t and n
Tf = zeros(1,4); % turns fraction
numF = zeros(1,4); % numerator of equivalent load formula
denF = zeros(1,4); % denominator of equivalent load formula


while abs(C0-C1) <= 0.001
    i = 0;
    i = i+1;
    
    for i=1:4
        fc(i) = Fa(i)/c0;
        e(i) = 0.505*fc(i)^0.231;
        fprintf('%d번째 Fa/c0 : %.3f\n', i,fc(i))
    end

    fprintf('\n')

    for i=1:4
        fafr(i) = Fa(i)/(V*Fr(i));
        if fafr(i) <= e(i)
            Xi(i) = 1.0;
            Yi(i) = 0.0;
        else
            Xi(i) = 0.56;
            Yi(i) = 0.84/fc(i)^0.24;
        end
    end

    for i=1:4
        Fe(i) = Xi(i)*V*Fr(i) + Yi(i)*Fa(i);
        Pc(i) = t(i)*n(i); % product of t and n 
    end

    for i=1:4
        Tf(i) = Pc(i)/sum(Pc);
        numF(i) = n(i)*t(i)*((af*Fe(i)^a)); % be aware of 'a'
        denF(i) = n(i)*t(i);
    end

    Feq = (sum(numF)/sum(denF))^(1/a); % equivalent load

    C1 = Feq*(xd/(x0+(th-x0)*((log(1/Rd))^(1/b))))^(1/a);

    fprintf('\n%d번째 계산된 C1 : %.3fkN\n\n', i, C1)
end

end

