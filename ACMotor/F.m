function dY = F(t,Y)
dY = zeros(5,1);
global U Ls Lr Lm Rs Rr p J T_frottement T_contrage f t_cpl t_dcpl,
% Rs=0.3;           %resistance statorique
% Ls=50*1e-3;       %inductance statorique
% Rr=0.4;           %resistance rotorique
% Lr=50*1e-3;       %inductance rotorique
% Lm=47*1e-3;       %inductance mutuelle
% p=2;              %nombre de paires de pole
% J=1;              %moment d'inertie
% T_frottement=0;
% T_contrage=0;
% f=50;
ws=2*pi*f;
Uds=sqrt(2)*U*cos(ws*t);
Uqs=sqrt(2)*U*sin(ws*t);
dY(1)=(Lr*(Uds-Rs*Y(1))+Lm*(Rr*Y(3)+Y(5)*(Lm*Y(2)+Lr*Y(4))))/(Ls*Lr-Lm^2); %ids
dY(2)=(Lr*(Uqs-Rs*Y(2))+Lm*(Rr*Y(4)-Y(5)*(Lm*Y(1)+Lr*Y(3))))/(Ls*Lr-Lm^2);%iqs
dY(3)=(Lm*(Uds-Rs*Y(1))+Ls*(Rr*Y(3)+Y(5)*(Lm*Y(2)+Lr*Y(4))))/(-Ls*Lr+Lm^2);%idr
dY(4)=(Lm*(Uqs-Rs*Y(2))+Ls*(Rr*Y(4)-Y(5)*(Lm*Y(1)+Lr*Y(3))))/(-Ls*Lr+Lm^2);%iqr
if (t_cpl<t_dcpl)
    if((t>=t_cpl)&&(t<t_dcpl))
        Text=T_contrage+T_frottement; %couple exterieure
    else
        Text=0;
    end
else
    Text=0;
end
dY(5)=(3*p/2*Lm*(Y(2)*Y(3)-Y(4)*Y(1))+Text)*p/J; %Wm
end