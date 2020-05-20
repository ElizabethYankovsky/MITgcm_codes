clear all
close all
%
%
load topo.mat
load tracer60.mat; load tracer61.mat; load tracer62.mat; 
load tracer63.mat; load tracer64.mat; load tracer65.mat;
load tracer70.mat; load tracer71.mat; load tracer72.mat;
load tracer73.mat; load tracer74.mat; load tracer75.mat;
load tracer76.mat; load tracer77.mat; load tracer78.mat;
load tracer79.mat; load tracerinflow.mat; load tracerNOinflow.mat;
load z.mat; load x.mat;
%
%
%
Zeqinflow = zeros(640,1); Zeq60 = zeros(640,1); Zeq61 = zeros(640,1); Zeq62 = zeros(640,1);
Zeq70 = zeros(640,1); Zeq71 = zeros(640,1); Zeq72 = zeros(640,1); Zeq73 = zeros(640,1); Zeq74 = zeros(640,1);
for ii = 1:640;
    Zeqinflow(ii) = nansum( tracerinflow(:,ii).*z(:) ) / nansum(tracerinflow(:,ii));
    Zeq60(ii) = nansum( tracer60(:,ii).*z(:) ) / nansum(tracer60(:,ii));
    Zeq61(ii) = nansum( tracer61(:,ii).*z(:) ) / nansum(tracer61(:,ii));
    Zeq62(ii) = nansum( tracer62(:,ii).*z(:) ) / nansum(tracer62(:,ii));
    Zeq70(ii) = nansum( tracer70(:,ii).*z(:) ) / nansum(tracer70(:,ii));
    Zeq71(ii) = nansum( tracer71(:,ii).*z(:) ) / nansum(tracer71(:,ii));
    Zeq72(ii) = nansum( tracer72(:,ii).*z(:) ) / nansum(tracer72(:,ii));
    Zeq73(ii) = nansum( tracer73(:,ii).*z(:) ) / nansum(tracer73(:,ii));
    Zeq74(ii) = nansum( tracer74(:,ii).*z(:) ) / nansum(tracer74(:,ii));
end

ZeqNOinflow = zeros(640,1); Zeq63 = zeros(640,1); Zeq64 = zeros(640,1); Zeq65 = zeros(640,1);
Zeq75 = zeros(640,1); Zeq76 = zeros(640,1); Zeq77 = zeros(640,1); Zeq78 = zeros(640,1); Zeq79 = zeros(640,1);
for ii = 1:640;
    ZeqNOinflow(ii) = nansum(tracerNOinflow(:,ii).*z(:))/nansum(tracerNOinflow(:,ii));
    Zeq63(ii) = nansum( tracer63(:,ii).*z(:) ) / nansum(tracer63(:,ii));
    Zeq64(ii) = nansum( tracer64(:,ii).*z(:) ) / nansum(tracer64(:,ii));
    Zeq65(ii) = nansum( tracer65(:,ii).*z(:) ) / nansum(tracer65(:,ii));
    Zeq75(ii) = nansum( tracer75(:,ii).*z(:) ) / nansum(tracer75(:,ii));
    Zeq76(ii) = nansum( tracer76(:,ii).*z(:) ) / nansum(tracer76(:,ii));
    Zeq77(ii) = nansum( tracer77(:,ii).*z(:) ) / nansum(tracer77(:,ii));
    Zeq78(ii) = nansum( tracer78(:,ii).*z(:) ) / nansum(tracer78(:,ii));
    Zeq79(ii) = nansum( tracer79(:,ii).*z(:) ) / nansum(tracer79(:,ii));
end
x=x/1000;

figure(102)
figure('Position',[514   667   650   620]);
axes('Position',[0.15 0.55 .8 0.40]);
plot(x(1:440),smooth(Zeq77(1:440),40),'--','Color',rgb('tangerine'),'Linewidth',2); hold on; grid on;
plot(x(1:550),smooth(Zeq64(1:550),30),'Color',rgb('golden yellow'),'Linewidth',2);
plot(x(1:610),smooth(Zeq79(1:610),40),'Color',rgb('yellowish green'),'Linewidth',2);
plot(x(1:610),smooth(ZeqNOinflow(1:610),40),'--','Color',rgb('irish green'),'Linewidth',2); 
plot(x(1:610),smooth(Zeq63(1:610),40),'Color',rgb('carolina blue'),'Linewidth',2); 
plot(x(1:610),smooth(Zeq65(1:610),40),'Color',rgb('blue'),'Linewidth',2);
plot(x(1:610),smooth(Zeq78(1:610),40),'Color',rgb('bluey purple'),'Linewidth',2);
plot(x(1:610),smooth(Zeq76(1:610),40),'--','Color',rgb('deep violet'),'Linewidth',2);
plot(x(1:610),smooth(Zeq75(1:610),40),'--','Color',rgb('light purple'),'Linewidth',2);


leg=legend('0.5x both','0.5x salt flux','0.5x heat flux','Original','2x heat flux','1.5x both','2x salt flux','2x both','3x both');
set(leg,'Units','inches')
%xlabel('X position (km)','Fontsize',14); xlim([0 75]); 
ylabel('Depth of plume (m)','Fontsize',14);
legend('location','southwest')
grid on
ylim([-400 0]); xlim([0 75]);
text(0.9,0.98,'a','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
load X2D.mat; area(X2D/1000,topo,-2500,'Facecolor',[.8 .8 .8])
set(gca,'Fontsize',12); set(gca,'Layer','top');
box on;


load XC.mat; load z.mat;
load X2D.mat; load z2D.mat;
%
load Tracer2D.mat; load Tracer3D.mat;
load Tracerdouble2D.mat; load Tracerdouble3D.mat;
load Tracerhalf2D.mat; load Tracerhalf3D.mat;
load Tracereighth2D.mat; load Tracereighth3D.mat;
%
%First doing the 2D cases:
for ii = 1:1280;
    Zhalf2(ii) = nansum(Tracerhalf2D(ii,:).*z2D')/nansum(Tracerhalf2D(ii,:));
    Zoriginal2(ii) =  nansum(Tracer2D(ii,:).*z2D')/nansum(Tracer2D(ii,:));
    Zdouble2(ii) = nansum(Tracerdouble2D(ii,:).*z2D')/nansum(Tracerdouble2D(ii,:));
    Zeighth2(ii) = nansum(Tracereighth2D(ii,:).*z2D')/nansum(Tracereighth2D(ii,:));
end
%Then the 3D cases:
for jj = 1:640
    Zhalf3(jj) = nansum(Tracerhalf3D(jj,:).*z')/nansum(Tracerhalf3D(jj,:));
    Zoriginal3(jj) =  nansum(Tracer3D(jj,:).*z')/nansum(Tracer3D(jj,:));
    Zdouble3(jj) = nansum(Tracerdouble3D(jj,:).*z')/nansum(Tracerdouble3D(jj,:));
    Zeighth3(jj) = nansum(Tracereighth3D(jj,:).*z')/nansum(Tracereighth3D(jj,:));
end


axes('Position',[0.15 0.1 0.8 0.40]);
plot(X2D(1:930)/1000,smooth(Zeighth2(1:930)),'Color',rgb('strawberry'),'Linewidth',2); hold on; grid on;
plot(X2D/1000,smooth(Zhalf2),'Color',rgb('tangerine'),'Linewidth',2);
plot(X2D/1000,smooth(Zoriginal2),'Color',rgb('irish green'),'Linewidth',2); 
plot(X2D/1000,smooth(Zdouble2),'Color',rgb('bluey purple'),'Linewidth',2);

plot(XC(1:470)/1000,smooth(Zeighth3(1:470)),':','Color',rgb('strawberry'),'Linewidth',2);
plot(XC(1:600)/1000,smooth(Zhalf3(1:600)),':','Color',rgb('tangerine'),'Linewidth',2); 
plot(XC/1000,smooth(Zoriginal3),':','Color',rgb('irish green'),'Linewidth',2); 
plot(XC/1000,smooth(Zdouble3),':','Color',rgb('bluey purple'),'Linewidth',2);
xlim([0 75]); ylim([-2500 0]);

set(gca,'Fontsize',12)
legend('1/8x both, 2D','0.5x both, 2D','Original, 2D','2x both, 2D','1/8x both, 3D','0.5x both, 3D','Original, 3D','2x both, 3D');

ylabel('Depth of plume (m)','Fontsize',14);
xlabel('X position (km)','Fontsize',14);
legend('location','southwest')
text(0.9,0.98,'b','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
area(X2D/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
box on; set(gca,'Layer','top')
%print(gcf,'fig3.jpg','-djpeg','-r500')






