close all
clear
clc
%% Ogranicenja i velicine
u_min = -15;
u_max = 15;
ref_min = -3;
ref_max = 3;
t1 = 10;
t2 = 150;
d_min = u_min/2;
d_max = u_max/2;
%% Pracenje reference
FIS_RT = readfis('FIS_Ref_Tracking');
e_max = 7;
ed_max = 0.55;

s1 = sim("FC_int_RT.slx");

du = s1.cont(:,1);
u = s1.cont(:,2);
e = s1.cont_input(:,1);
de = s1.cont_input(:,2);
y = s1.reg_var(:,1);
r = s1.reg_var(:,2);
t = s1.time;

close all;

figure(1)
hold on
plot(t,u,LineWidth=2)
yline(u_min,color='k',LineStyle='--')
yline(u_max,color='k',LineStyle='--')
yline(u(end),color='r',LineStyle='--',Label='u_{ravn}',LabelColor='k',LabelHorizontalAlignment='center')
xline(t1,color='k',LineStyle='--')
xline(t2,color='k',LineStyle='--')
xlabel('t[s]')
ylabel('u')
title('Upravljanje u vremenu')
xlim([t(1) t(end)])
ylim([u_min-1 u_max+1])

figure(2)
hold on
plot(t,e,LineWidth=2)
plot(t,de,LineWidth=2)
xline(t1,color='k',LineStyle='--')
xline(t2,color='k',LineStyle='--')
xlabel('t[s]')
ylabel('e,de')
title('Ulazne promenljive fazi sistema u vremenu')
xlim([t(1) t(end)])
ylim([-1.05 1.05])
legend('e','de')

figure(3)
hold on
plot(t,y,LineWidth=2)
plot(t,r,'r')
xlabel('t[s]')
ylabel('y')
title('Regulisana promenljiva u vremenu')
xlim([t(1) t(end)])
ylim([1.05*ref_min 1.05*ref_max])
legend('y','ref')
%% Potiskivanje poremecaja
FIS_D = readfis('FIS_Disturbance');
e_max = 0.9;
ed_max = 0.36;

s2 = sim("FC_int_D.slx");

du = s2.cont(:,1);
u = s2.cont(:,2);
e = s2.cont_input(:,1);
de = s2.cont_input(:,2);
y = s2.reg_var;
t = s2.time;

%close all;

figure(4)
hold on
plot(t,u,LineWidth=2)
yline(d_min,color='k',LineStyle='--')
yline(d_max,color='k',LineStyle='--')
xline(t1,color='k',LineStyle='--')
xline(t2,color='k',LineStyle='--')
xlabel('t[s]')
ylabel('u')
title('Upravljanje u vremenu')
xlim([t(1) t(end)])
ylim([min(u)-1 max(u)+1])

figure(5)
hold on
plot(t,e,LineWidth=2)
plot(t,de,LineWidth=2)
xline(t1,color='k',LineStyle='--')
xline(t2,color='k',LineStyle='--')
xlabel('t[s]')
ylabel('e,de')
title('Ulazne promenljive fazi sistema u vremenu')
xlim([t(1) t(end)])
ylim([-1.05 1.05])
legend('e','de')

figure(6)
hold on
plot(t,y,LineWidth=2)
yline(0,color='k',LineStyle="--")
yline(0,color='k',LineStyle='--')
xlabel('t[s]')
ylabel('y')
title('Regulisana promenljiva u vremenu')
xlim([t(1) t(end)])
ylim([1.05*min(y) 1.05*max(y)])
