function datanew = carStopDtect(data)
datanew = data;
% ��ȡ�ٶȡ�ת�١���������
data_temp = cell2mat(datanew(2:end,[2,8,11]));
% �ҳ��ٶ�Ϊ0������
v_index = find(data_temp(:,1)==0);
% �ҳ����ſ���Ϊ0������
throttle_index = find(data_temp(:,3)==0);
% �ҳ��ٶȺ�����Լ���µĿ�������
deal_index = intersect(v_index,throttle_index);
r_min = mean(data_temp(deal_index,2)); % ȡת�پ�ֵ��Ϊ����ת��
% �ҳ�����ת����Сֵ
r_index = find(data_temp(:,2)<= r_min);
% �ҵ��������������
deal_index2 = intersect(deal_index,r_index);
% �ҳ�����������
deal_index3 = is_continue(deal_index2);
% ͳ������Ƭ�γ���
for i = 1:length(deal_index3)
    index3_length(i) = length(deal_index3{i});
end
% �ҳ�����180s�����ݶ�
deal_index4 = find(index3_length > 180);

% �쳣���ݼ�¼
erro_part = length(deal_index4);
erro_num = sum(index3_length(deal_index4));
text1 = sprintf('�ҵ�����ͣ����Ϩ����߲�Ϩ��Ƭ��%d����������%d�����ݣ������޳�...\n',erro_part,erro_num);
fprintf(text1);
% ��Ӧ�������ݶν����޳�������Ĩ��nan��
for i = 1:length(deal_index4)
    datanew(cell2mat(deal_index3(deal_index4(i)))+1,2:end) = {nan};
end
fprintf('����ͣ���쳣������ɣ�\n');
end