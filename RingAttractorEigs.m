prefang = 0:pi/50:pi-0.0001;
angdiff = prefang - prefang';
wmat = cos(angdiff);
[evc,eva] = eig(wmat);
%%
figure('pos',[100         100        1233         350])
T = tiledlayout(1,3,'TileSpac','compact','Pad','compact');
nexttile(T,1);
imagesc(wmat)
colorbar()
title("Weight matrices")
axis image
nexttile(T,2);
plot(diag(eva))
title("eigenvalues")
nexttile(T,3);
plot(evc(:,end));hold on
plot(evc(:,end-1))
title("eigenvectors")
%%
figure;
plot(evc(:,1:end-2))