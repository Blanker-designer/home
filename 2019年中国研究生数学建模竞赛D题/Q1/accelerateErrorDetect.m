function datanew = accelerateErrorDetect(data)
datanew = data;
% ��ȡ�ٶ�
data_temp = cell2mat(datanew(2:end,2));
a = data_temp;
% ������ٶȼ�������
a_before = a(1:end-1);
a_after = a(2:end);
% ������ٶ�
a_delta = a_after - a_before;
% �����ٶ�����ֵ
p_v = 100/7;
% �����ٶ�����ֵ
n_v = -8*3600/1000;
% ��¼���ٶ��쳣ֵ
p_index = [];
n_index = [];
for i = 1:length(a_delta)
    if a_delta(i) > p_v
        p_index = [p_index,i];
    elseif a_delta(i) < n_v
        n_index = [n_index,i];
    end
end
% ���Ų���쳣��λ��
p_index = p_index + 1;
n_index = n_index + 1;

% �쳣���ݼ�¼
fprintf('�ҵ����ٶ��쳣����%d���������쳣����%d�����쳣ɲ��%d���������޳�...\n',...
    length([p_index,n_index]),length(p_index),length(n_index));
erro_index = [p_index,n_index]+1;
for i = 1:length(erro_index)
    datanew(erro_index(i),2:end) = {nan};
end
fprintf('���ٶ��쳣������ɣ�\n');
end
