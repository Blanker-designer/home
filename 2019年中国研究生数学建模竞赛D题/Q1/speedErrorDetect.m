function datanew = speedErrorDetect(data)
datanew = data;
% ��ȡ�ٶ�
data_temp = cell2mat(datanew(2:end,2));
erro_index = find(data_temp > 120 );
text1 = sprintf('�ҵ��ٶ��쳣����%d���������޳�...\n',length(erro_index));
fprintf(text1);
datanew(erro_index+1,2:end) = {nan};
fprintf('�ٶ��쳣������ɣ�\n');
end