function dealFile(filename)
% ��������
fprintf('���ڵ���%s...\n',filename);
load([filename,'����Ԥ�����'],'datanew');
data = datanew;
fprintf('����ɹ���һ������%d������\n',length(data)-1);
% ѡȡ�˶�ѧƬ��
kinepart = kinePartDetect(data);
% �����˶�ѧƬ��
save([filename,'�˶�ѧƬ��'],'kinepart');
end