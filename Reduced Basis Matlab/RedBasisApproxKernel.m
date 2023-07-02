%% Reduced kernel basis approximation

gail.InitializeWorkspaceDisplay

kernel = @(t,x) exp(- 10*(t - x').^2); %reproducing kernel
m = 10; %subsample size
mult = 5; %multiplier 
n = mult*m; %full sample size
xsample = (0:n)'/n; %full sample
xbasis = xsample(1:mult:n+1); %subsample that defines the basis
nplot = 1000; %number of points for plotting the test function
xplot = (0:nplot)'/nplot;
Kss = kernel(xsample,xsample);
Kbb = kernel(xbasis,xbasis);
Ksb = kernel(xsample,xbasis);
Kpb = kernel(xplot,xbasis);
basis = @(x) kernel(xbasis,x);
sbasis = @(x) kernel(xsample,x);

%% Plot
figure(1);
h = pcolor(xsample,xsample,Kss);
set(h,'EdgeColor', 'none','facecolor','interp')
xlabel('\(t\)')
ylabel('\(x\)')
title('\(K(t,x)\)')
axis([0 1, 0 1],'square')
set(gca,'xtick',0:0.2:1)
colorbar

figure
hold on
for i = 1:m+1
    scatter(xbasis, xbasis(i)*ones(m+1,1), 100, Kbb(:,i),'filled')
end
xlabel('\(x\)')
ylabel('\(t\)')
title('\(K(t_i,x_j)\)')
axis([0 1, 0 1],'square')
set(gca,"Clim",[0,1],"xtick",0:0.2:1)
colorbar

figure
hold on
for i = 1:m+1
    xx = xbasis(i)*ones(n+1,1);
    zz = zeros(size(xsample));
    surface([xsample xsample], [xx xx], [zz zz], [Ksb(:,i) Ksb(:,i)], ...
        'facecol','no', ...
        'edgecol','interp',...
        'linew',5);
end
xlabel('\(x\)')
ylabel('\(t_i\)')
title('\(K(x,t_i)\)')
axis([0 1, 0 1],'square')
set(gca,"Clim",[0,1],"xtick",0:0.2:1)
colorbar

return




