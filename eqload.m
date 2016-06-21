%% MATLAB code for computing the equivalent radial load on the bearing %%
function eqload(Fa,Fr,C0_r)

fc = Fa/C0_r;
e = 0.505*fc^0.231;
fafr = Fa/Fr;
if fafr <= e
    X = 1.0;
    Y = 0.0;
else
    X = 0.56;
    Y = 0.84/fc^0.24;
end

% Dynamic equivalent radial load on the bearing %
Pm = X*Fr + Y*Fa;
disp(Pm);