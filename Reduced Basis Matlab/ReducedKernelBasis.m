%% Reduced kernel basis approximation

gail.InitializeWorkspaceDisplay

f = @(x) x.*sin(20*x); %test function
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
fbasis = f(xbasis);
fsample = f(xsample);
fplot = f(xplot);
fbappx = @(x) (fbasis'/Kbb)*basis(x);
fsappx = @(x) (fsample'/Kss)*sbasis(x);
fbappxplot =  fbappx(xplot)';
fsappxplot =  fsappx(xplot)';

%% Plot
figure(1);
plot(xplot,[fplot,fbappxplot,fsappxplot])

