function drawVTpic(filename)

set(gcf,'outerposition',get(0,'screensize'))

% �����쳣����ǰ����
[~,~,data1] = xlsread(filename);
plotdata1 = cell2mat(data1(2:end,2));
subplot(211)
plot(plotdata1)
grid on
set(gca,'fontsize',24)
xlabel('ʱ�䣨s��'),ylabel('���٣�km/h��');
set(gca,'GridLineStyle','--','GridColor','k','GridAlpha',1)
title([filename,'����Ԥ����ǰ']);

% �����쳣���������
load([filename,'����Ԥ�����'],'datanew');
data2 = datanew;
plotdata2 = cell2mat(data2(2:end,2));
x = data2{2,1};
x_hour =str2double(x(12:13));
x_min =str2double(x(15:16));
x_second =str2double(x(18:19));
t1 = (23-x_hour)*3600 + (59-x_min)*60 + (59-x_second)*1 +1;

subplot(212)
plot(plotdata2)
grid on
set(gca,'xtick',[1,t1:86400:length(plotdata2)],'xticklabel',0:1:6,'fontsize',24)
xlabel('ʱ�䣨����Ϊ����λ��'),ylabel('����');
set(gca,'GridLineStyle','--','GridColor','k','GridAlpha',1)
title([filename,'����Ԥ�����'])
print(gcf,'-djpeg','-r300',[filename,'����Ԥ����ǰ��Ա�ͼ']);

fprintf('%s����Ԥ����ǰ��Ա�ͼ������ɣ�\n',filename)
end