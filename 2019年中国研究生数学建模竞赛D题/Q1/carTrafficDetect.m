function datanew = carTrafficDetect(data)
datanew = data;
% ��ȡ�ٶ�
data_temp = cell2mat(datanew(2:end,2));
% �ҳ��ٶ�С��10km/h������
v_index = find(data_temp(:,1) < 10);
% �ҳ�������Ƭ��
deal_index1 = is_continue(v_index);
% ͳ������Ƭ�γ���
for i = 1:length(deal_index1)
    index1_length(i) = length(deal_index1{i});
end
% �ҳ�����180s�����ݶ�
deal_index2 = find(index1_length > 180);
% �쳣���ݼ�¼
erro_part = length(deal_index2);
erro_num = sum(index1_length(deal_index2));
text1 = sprintf('�ҵ��³���ɵĳ�������Ƭ��%d����������%d�����ݣ������޳�...\n',erro_part,erro_num);
fprintf(text1);
% ��Ӧ�������ݶν��е��ٴ�������Ĩ��0��
for i = 1:length(deal_index2)
    datanew(cell2mat(deal_index1(deal_index2(i)))+1,2) = {0};
end
fprintf('�³������쳣������ɣ�\n');
end