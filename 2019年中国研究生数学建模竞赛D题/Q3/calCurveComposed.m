function curveComposed = calCurveComposed(kinePartSorted,sectionTime,sectionSpeed)
for i = 1:3
    % ����Ƭ��ʱ��
    kinePart_now = kinePartSorted{i};
    m = length( kinePart_now);
    part_time = zeros(m,1);
    for j = 1:m
        part_time(j) = length( kinePart_now{j});
    end 
    % ѡȡƬ��
    time_min = sectionTime(i,1);time_max= sectionTime(i,2);
    is_choose = choosePart(part_time,time_min,time_max);
    kinePart_curve = kinePart_now(is_choose==1,1);
    
    % �õ�Ƭ�ι�������
    curve_temp{i,1}= kinePart_curve;
end
[~,index]= sort(sectionSpeed(:,1));

curveComposed = [...
   cell2mat( curve_temp{index(1),1});...
   cell2mat( curve_temp{index(2),1});...
   cell2mat( curve_temp{index(3),1});...
];
% ���ϳɹ�������ͼ
figure;
set(gcf,'outerposition',get(0,'screensize'))
plot(curveComposed,'r-','linewidth',2)
xlabel('ʱ�䣨s��'),ylabel('���٣�km/h��')
title('�ϳɹ�������');
grid on
set(gca,'GridLineStyle','--','GridColor','k','GridAlpha',1,'fontsize',24);
axis tight
print(gcf,'-djpeg','-r300','�ϳɹ�������');
fprintf('%s������ɣ�\n','�ϳɹ�������')
end