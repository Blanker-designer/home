function group =myK_means(data,k)
% ����kmeans�㷨
% k = 3; % ��������
iteration =15000 ; % �������ѭ������
distance = 'sqEuclidean'; % ���뺯��
opts = statset('MaxIter',iteration);
index = kmeans(data,k,'distance',distance,'Options',opts);

group = cell(k,1);
for i = 1:k
    group{i} = find(index==i);
end
save('������','group');
fprintf('K-Means���������ɣ�\n');
end