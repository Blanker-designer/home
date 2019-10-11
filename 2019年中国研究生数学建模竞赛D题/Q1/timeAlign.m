function datanew = timeAlign(data)
% �����м�¼GPS��ʱ��
record_time = date2second2(data(2:end,1))';
% ������ֹ��
time_start = date2second(data{2,1});
time_end = date2second(data{end,1});
time = time_start:time_end;
% ʱ����룬���Ҷ������
[~,col] = ismember(record_time,time);
errodataNum = length(time) - length(col);
text1 = sprintf('��GPS�豸�ϵ�����쳣��������ȱʧ��%d������,���ڲ���...\n',errodataNum);
fprintf(text1);
% �����޸���Ԫ��
data_deal = cell(length(time)+1,size(data,2));
data_deal(:) = {nan};
data_deal([1,col+1],:) = data;
datanew  = data_deal;
% ʱ�仹ԭ
datanew(2:end,1) = second2date(data{2,1},time);
fprintf('ʱ�������ɣ�\n');
end