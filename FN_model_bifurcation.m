F = repmat(getframe(gcf),1,0);
i = 0;
for I_current = 0.0:0.01:1.5
FNmodel = @(X) [(X(1) - X(1).^3 - X(2) + I_current);...
                0.08 * (X(1) + 0.7 - 0.8*X(2))];
xfix = fsolve(FNmodel,[0,0]);
FNmodel_t = @(t,X) [(X(1) - X(1).^3 - X(2) + I_current);...
                0.08 * (X(1) + 0.7 - 0.8*X(2))];
figure(1)
ezplot(@(x)x-x.^3+I_current,[-2,2])
hold on 
ezplot(@(x)(x+0.7)/0.8,[-2,2])
[t_ticks, traj] = ode45(FNmodel_t, [0, 200], xfix + [0.3,0.3]);
plot(traj(:,1),traj(:,2),'LineWidth',1.5,'Color',[0,1,0,0.4])
[t_ticks, traj] = ode45(FNmodel_t, [0, 200], xfix + [-0.3,0.3]);
plot(traj(:,1),traj(:,2),'LineWidth',1.5,'Color',[1,0,1,0.4])
[t_ticks, traj] = ode45(FNmodel_t, [0, 200], xfix + [-0.3,-0.3]);
plot(traj(:,1),traj(:,2),'LineWidth',1.5,'Color',[0,1,1,0.4])
plot(xfix(1),xfix(2),'ro')
xlim([-2,2])
ylim([-2,4])
title(["I Current input",I_current])
xlabel("V")
ylabel("W")
hold off
F(end+1) = getframe(gcf) ;
drawnow
i = i+1;
end
%%
% create the video writer with 1 fps
writerObj = VideoWriter('FN_bifurcate2.avi');
writerObj.FrameRate = 20;
  % set the seconds per image
% open the video writer
open(writerObj);
% write the frames to the video
for i=1:length(F)
    % convert the image to a frame
    frame = F(i) ;    
    writeVideo(writerObj, frame);
end
% close the writer object
close(writerObj);