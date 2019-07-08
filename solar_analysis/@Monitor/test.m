
T=300:-10:100;E=exp(1./T); % Define a dummy set of data
figure;
plot(1000./T,E);
xlabel('1000/T / K^{-1}') % Plot the data
LinkTopAxisData(1000./(300:-50:100),300:-50:100,'T / K');