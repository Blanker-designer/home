function [sectionSpeed,sectionTime] = calSection(curve,kinePart)
% �������๤������
curveDistFeature = calDistFeature(curve);
curvebardata = [...
    curveDistFeature.neglect_time;...
    curveDistFeature.accelerate_time;...
    curveDistFeature.slowdown_time;...
    curveDistFeature.unispeed_time,...
    ];
curvebarname = {'����ģʽ','����ģʽ','����ģʽ','����ģʽ'};
figure;set(gcf,'outerposition',get(0,'screensize'));
groupName = {'��һ�๤������','�ڶ��๤������','�����๤������'};
bar(curvebardata),legend(groupName),grid on;
set(gca,'xticklabel',curvebarname,'fontsize',24,'GridLineStyle','--','GridColor','k','GridAlpha',1);
print(gcf,'-djpeg','-r300','���๤�����ߵ�����ģʽ�Ա�');
% �����ٶ�����
sectionSpeed = calSpeedSection(curveDistFeature);

% �����ٶ������������
sectionTime = calSectionTime(sectionSpeed,kinePart);
end