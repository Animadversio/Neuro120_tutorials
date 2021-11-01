alpha_n = @(V) 0.01 * (V + 55) / (1 - exp(-.1 * (V + 55)));
alpha_m = @(V) 0.1 * (V + 40) / (1 - exp(-.1 * (V + 40)));
alpha_h = @(V) 0.07 * exp( -.05 * (V + 65));
beta_n = @(V) 0.125 * exp(-0.0125 * (V + 65));
beta_m = @(V) 4 * exp(-0.0556 * (V + 65));
beta_h = @(V) 1 / (1 + exp(-.1 * (V + 35)));

Cm = 10;
% Equilibrium condunctances
gK = 360 ;
gNa = 1200 ;
gL = 3 ;
ENa = 57;
Ek = -77;
EL = -54;
%%
figure(1); clf;hold on 
for I_ext = 20:5:600
HHeqs = @(t,X) [(I_ext - gL * (X(1) - EL) - gNa * X(3).^3 .* X(4) .* (X(1) - ENa) - gK * X(2).^4 * (X(1) - Ek)) / Cm , %dV = 
				alpha_n(X(1)) * (1 - X(2)) - beta_n(X(1)) * X(2), %dn = 
				alpha_m(X(1)) * (1 - X(3)) - beta_m(X(1)) * X(3), %dm = 
				alpha_h(X(1)) * (1 - X(4)) - beta_h(X(1)) * X(4) ]; %dh = 

xequ = fsolve(@(X)HHeqs(0,X), [-60,0,0,0]);
traj = ode45(HHeqs, [0:1:3200], xequ+[0.1,0.05,0.05,0.05]);

plot3(traj.y(1,:),traj.y(2,:),traj.y(4,:),'color','blue')
end
%%
figure(2); clf;hold on 
clrs = jet(119);i=1;
for I_ext = 10:5:600
HHeqs_red = @(t,X) [(I_ext - gL * (X(1) - EL) - gNa * (alpha_m(X(1))/(alpha_m(X(1)) + beta_m(X(1)))).^3 .* X(3) .* (X(1) - ENa) - gK * X(2).^4 * (X(1) - Ek)) / Cm , %dV = 
				alpha_n(X(1)) * (1 - X(2)) - beta_n(X(1)) * X(2), %dn = 
% 				alpha_m(X(1)) * (1 - X(3)) - beta_m(X(1)) * X(3), %dm = 
				alpha_h(X(1)) * (1 - X(3)) - beta_h(X(1)) * X(3) ]; %dh = 

xequ = fsolve(@(X)HHeqs_red(0,X), [-60,0,0]);
traj = ode45(HHeqs_red, [0:1:3200], xequ+[0.1,0.05,0.05]);

plot3(traj.y(1,2000:end),traj.y(2,2000:end),traj.y(3,2000:end),'color',clrs(i,:))
i=i+1;
end
xlabel("V(mV)");ylabel("n");zlabel("h")
%%
