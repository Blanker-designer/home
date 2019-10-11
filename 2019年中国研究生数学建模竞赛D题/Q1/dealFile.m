function dealFile(filename)
% ��������
path = filename;
[~,~,data] = xlsread(path);
fprintf('%s����ɹ���һ������%d������\n',filename,length(data)-1);

% ʱ����봦��
data1 = timeAlign(data);

% ��γ���쳣����
data2  = locatErroDetct(data1);

% ����ͣ����Ϩ����
data3 = carStopDtect(data2);

% �³����ٴ���
data4 = carTrafficDetect(data3);

% GPS��ʱ��ʧ����
data5 = gpsMissDetect(data4);

% ���ٶ��쳣����
data6 = accelerateErrorDetect(data5);

% �ٶ��쳣����
data7 = speedErrorDetect(data6);

% ë���쳣����
data8 = burrDetect(data7);

% �洢��������
datanew = data8;

% �����쳣���ݴ���������
save([filename,'����Ԥ�����'],'datanew');

fprintf('%s����Ԥ������ɣ�\n',filename);
end
