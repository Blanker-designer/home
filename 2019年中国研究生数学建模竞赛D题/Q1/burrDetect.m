function datanew = burrDetect(data)
datanew = data;
% ��ȡ�ٶ�
data_temp = cell2mat(datanew(2:end,2));
% �ҳ��ٶȴ���0������
v_index = find(data_temp(:,1)>0);
% �ҳ�������Ƭ��
deal_index1 = is_continue(v_index);
% ͳ������Ƭ�γ���
for i = 1:length(deal_index1)
    index1_length(i) = length(deal_index1{i});
end
% �ҳ�����С��4s�����ݶ�
deal_index2 = find(index1_length < 4);
% �쳣���ݼ�¼
erro_part = length(deal_index2);
erro_num = sum(index1_length(deal_index2));
text1 = sprintf('�ҵ�ë��Ƭ��%d����������%d�����ݣ����ڵ��ٴ���...\n',erro_part,erro_num);
fprintf(text1);
% ��Ӧ�������ݶν��е��ٴ�������Ĩ��0��
for i = 1:length(deal_index2)
    datanew(cell2mat(deal_index1(deal_index2(i)))+1,2) = {0};
end
fprintf('ë���쳣������ɣ�\n');
end