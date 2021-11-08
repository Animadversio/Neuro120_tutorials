%% Random Basis 
rndM = randn(3);
rndM = rndM ./ sqrt(sum(rndM.^2,1));

%% Set the kernel (Eigenvalue matrix)
a = -0.05; b = 5.5;
l3 = -0.01;
D = [ a  b   0;
     -b  a   0;
      0  0  l3];
 
%% Set dynamic matrix and run!
M = rndM * D * inv(rndM);

X0 = [10,10,10];
odesol = ode45(@(t,X)M*X,[0 50],X0,odeset('RelTol',1E-6));
figure;%plot3(odesol.y(1,:),odesol.y(2,:),odesol.y(3,:),'k');hold on 
patch([odesol.y(1,:),nan],[odesol.y(2,:),nan],[odesol.y(3,:),nan],[odesol.x,nan],'FaceColor','none','EdgeColor','interp');hold on
% scatter3(odesol.y(1,:),odesol.y(2,:),odesol.y(3,:),9,odesol.x);
axis equal
Scale=set_scale();
plot3(Scale*[0,rndM(1,1)],Scale*[0,rndM(2,1)],Scale*[0,rndM(3,1)],'r','LineWidth',2.0)
plot3(Scale*[0,rndM(1,2)],Scale*[0,rndM(2,2)],Scale*[0,rndM(3,2)],'g','LineWidth',2.0)
plot3(Scale*[0,rndM(1,3)],Scale*[0,rndM(2,3)],Scale*[0,rndM(3,3)],'b','LineWidth',2.0)
legend(["Traj X","Traj X","Eigv1","Eigv2","Eigv3"])
function Scale=set_scale()
XLIM = xlim();
YLIM = ylim();
ZLIM = zlim();
Scale = 0.3*min([XLIM(2)-XLIM(1),YLIM(2)-YLIM(1),ZLIM(2)-ZLIM(1)]);
end