clear all
close all

forcing = 1*10^-5*[.43 .85 1.71 2.56 3.41 5.11 6.82];
%average ratio of eke to mke for the last 20 days
EKE_MKE = [.368 .272 2.32 2.30 4.27 8.13 12.6];
%average ratio of eke to (mke+eke) for last 20 days 
EKE_tot = [.268 .213 .666 .633 .73 .865 .901];

figure(1)
plot(forcing, EKE_MKE,'*')
xlabel('Buoyancy forcing, [kg/(m^2 s)]');
ylabel('mean(EKE/MKE) for last 20 days');
title('EKE/MKE ratio vs. forcing')
grid on

figure(2)
plot(forcing,EKE_tot,'*')
xlabel('Buoyancy forcing, [kg/(m^2 s)]');
ylabel('mean(EKE/(MKE+EKE)) for last 20 days');
title('EKE/KE ratio vs. forcing')
grid on

figure(3)
loglog(forcing,EKE_tot,'*','Linewidth',1.5,'Color',[0 0 0.5]); grid on;
[a]=polyfit(log10(forcing),log10(EKE_tot),1);
hold on 
x=linspace(10^-6,10^-4,100);
loglog(x,10.^(a(1,1)*log10(x)+a(1,2)),'Color',[0 0 .5],'Linewidth',1.5);
xlabel('Forcing [kg/(m^3)]')
ylabel('mean(EKE/(MKE+EKE)) for last 20 days')
title('EKE/KE vs. forcing fitting')
text(10^-5.5,0.5,sprintf('y = %.1f x+ %.2f', a(1),a(2)))