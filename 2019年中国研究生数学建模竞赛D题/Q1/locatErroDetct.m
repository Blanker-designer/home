function datanew = locatErroDetct(data)
datanew = data;
% ��ȡ��γ������
data_temp =sum( cell2mat(datanew(2:end,6:7)),2);
% �ҵ�ȫΪ0�����ݣ������޳�����Ϊnan��
erro_index = find(data_temp==0);
text1 = sprintf('�ҵ���γ���쳣����%d���������޳�...\n',length(erro_index));
fprintf(text1);
datanew(erro_index+1,2:end) = {nan};
fprintf('��γ���쳣������ɣ�\n');
end