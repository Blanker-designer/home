function datanew = gpsMissDetect(data)
datanew = data;
% ��ȡ�ٶ�
data_temp = cell2mat(datanew(2:end,2));
% ��ʱGPS��ʧ�޸���2s��ֵ�岹����
fix_num = 0; % ��¼��������ݸ���
for i = 2:length(data_temp)-1
    if ~isnan(data_temp(i-1)) && isnan(data_temp(i)) && ~isnan(data_temp(i+1))
        data_temp(i) = mean([data_temp(i-1),data_temp(i+1)]);
        fix_num = fix_num + 1;
    end
end

for i = 2:length(data_temp)+1
    datanew{i,2} = data_temp(i-1);
end
fprintf('�ҵ�GPS��ʱ��ʧ���ݣ���ʧ1s��%d������ͨ����ֵ�޸���\n', fix_num);
end