function [kinePartSorted,curve] = calCurve2(kinePart,group)
for i = 1:3
 kinePart_g1 = kinePart(group{i,1},1);   
%  ��������ֲ�����ָ��
[~,partDistFeature_mat ]= calDistFeature(kinePart_g1);
% ���ָ���ֵ
partDistFeature_mean = mean(partDistFeature_mat);

% �������ƶȣ���������
m = length(partDistFeature_mat);
pearsonCorr = zeros(m,1);
for j = 1:m
    pearsonCorr(j) = myPearson(partDistFeature_mat(j,:),partDistFeature_mean);
end   
[~,mostCorr_index]= sort(pearsonCorr,'descend');
kinePart_g1_sorted = kinePart_g1(mostCorr_index);

% ����Ƭ��ʱ��
part_time = zeros(m,1);
for k = 1:m
    part_time(k) = length(kinePart_g1_sorted{k,1});
end

% ѡȡ 1200 ~ 1300s Ƭ��
is_choose = choosePart(part_time,1200,1300);
kinePart_curve = kinePart_g1_sorted(is_choose==1,1);

% �õ����յĹ�������
curve1 = cell2mat(kinePart_curve);

% �洢������Ƭ�Σ��Լ���Ӧ�Ĺ�������
kinePartSorted{i} = kinePart_g1_sorted;
curve{i} = curve1;
end

% �����๤������ͼ
fprintf('���๤�����߼�����ɣ�\n');
groupName = {'��һ�๤������','�ڶ��๤������','�����๤������'};
for i = 1:length(groupName)
    figure;
    set(gcf,'outerposition',get(0,'screensize'))
    plot(curve{i},'r-','linewidth',2)
    xlabel('ʱ�䣨s��'),ylabel('���٣�km/h��')
    title(groupName{i});
    grid on
    set(gca,'GridLineStyle','--','GridColor','k','GridAlpha',1,'fontsize',24);
    axis tight
    print(gcf,'-djpeg','-r300',groupName{i});
    fprintf('%s������ɣ�\n',groupName{i})
end

end