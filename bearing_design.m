function bearing_design(c0,in_out)
%% initial setting %%
% taxi before take off, take off, landing, taxi after landing 
Fr = [996.924 906.999 558.834 339.975]; % radial load (N)
t = [(20/60) (10/60) (10/60) (20/60)]; % time fraction
n = [27.849 661.823 639.544 27.849]; % angular speed (RPM)
Fa = [47.635 47.456 45.672 45.672]; % axial load (N)
af = 1.5;
v = length(Fr); % number of variable loading

ld = 30000; % desired life (hour)
nd = 670; % desired rpm (maximum)

xd = (60*ld*nd)/(10^6);
x0 = 0.02;
th = 4.439;
Rd = sqrt(0.99);
a = 3; % for roller bearing
b = 1.483;
if in_out == 'inner'
    V = 1; % for inner ring rotates
elseif in_out == 'outer'
    V = 1.2; % for outer ring rotates
end

%% iteration until it converges %%

% preallocation of matrix %
fc = zeros(1,v); % fc = Fa/C0_r;
e = zeros(1,v);
Xi = zeros(1,v);
Yi = zeros(1,v);
fafr = zeros(1,v); % Fa/VFr
Fe = zeros(1,v); % equivalent load
Pc = zeros(1,v); % product of t and n
Tf = zeros(1,v); % turns fraction
numF = zeros(1,v); % numerator of equivalent load formula
denF = zeros(1,v); % denominator of equivalent load formula


    c = 1;
    c = c+1;
    
    for i=1:v
        fc(i) = Fa(i)/c0;
        e(i) = 0.505*fc(i)^0.231;
        fprintf('%d번째 Fa/c0 : %.3f\n', i,fc(i))
    end

    fprintf('\n')

    for i=1:v
        fafr(i) = Fa(i)/(V*Fr(i));
        if fafr(i) <= e(i)
            Xi(i) = 1.0;
            Yi(i) = 0.0;
        else
            Xi(i) = 0.56;
            Yi(i) = 0.84/fc(i)^0.24;
        end
    end

    for i=1:v
        Fe(i) = Xi(i)*V*Fr(i) + Yi(i)*Fa(i);
        Pc(i) = t(i)*n(i); % product of t and n 
    end

    for i=1:v
        Tf(i) = Pc(i)/sum(Pc);
        numF(i) = n(i)*t(i)*((af*Fe(i)^a)); % be aware of 'a'
        denF(i) = n(i)*t(i);
    end

    Feq = (sum(numF)/sum(denF))^(1/a); % equivalent load

    C1 = Feq*(xd/(x0+(th-x0)*((log(1/Rd))^(1/b))))^(1/a);

    fprintf('\n%d번째 계산된 C1 : %.3fN\n\n', c, C1)

end

