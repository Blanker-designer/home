function [kinePart_g1_sorted,curve1] = calCurve(kinePart_g1)

%  ��������ֲ�����ָ��
partDistFeature = calDistFeature(kinePart_g1);
partDistFeature_mat = cell2mat(reshape(struct2cell(partDistFeature),12,length(partDistFeature))');

% ���ָ���ֵ
partDistFeature_mean = mean(partDistFeature_mat);

% �������ƶȣ���������
m = length(partDistFeature_mat);
pearsonCorr = zeros(m,1);
for i = 1:m
    pearsonCorr(i) = myPearson(partDistFeature_mat(i,:),partDistFeature_mean);
end   
[~,mostCorr_index]= sort(pearsonCorr,'descend');
kinePart_g1_sorted = kinePart_g1(mostCorr_index);

% ����Ƭ��ʱ��
part_time = zeros(m,1);
for i = 1:m
    part_time(i) = length(kinePart_g1_sorted{i,1});
end

% ѡȡ 1200 ~ 1300s Ƭ��
is_choose = choosePart(part_time,1200,1300);
kinePart_curve = kinePart_g1_sorted(is_choose==1,1);

% �õ����յĹ�������
curve1 = cell2mat(kinePart_curve);
end