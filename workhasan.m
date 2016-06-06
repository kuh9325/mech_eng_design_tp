function Kb2 = workhasan(Kb1)
Sut = 570;
Sy = 310;
Ka = 57.7*(Sut^-0.718);
Se1 = 0.5*Sut;
f = 0.87;
Kb2 = 4 %아무 값이나 초기화
while abs(Kb1-Kb2) >= 0.0001 %수렴시 반복 종료
    Se = Ka*Kb1*Se1;
    a = ((f*Sut)^2)/Se;
    b = (-1/3)*log10((f*Sut)/Se);
    Sf = a*((10^4)^b);
    l = ((1.5*7200)/(Sf*10^6))^(1/3)
    de = 0.808*l*(10^3)
    if de >= 2.79 && de <= 51
        Kb2 = 1.24*(de^-0.107);
    elseif de > 51 && de<= 254
        Kb2 = 1.51*(de^-0.107);
    end
    if abs(Kb1 - Kb2) >= 0.0001
        Kb1 = Kb2;
        Kb2 = 10; %루프 자동 탈출방지
    else
        Kb1
        Kb2
    end  
end
end

