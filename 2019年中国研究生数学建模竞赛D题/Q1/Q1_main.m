%% ׼���洢�ռ�
clc,clear,close all

filename = {'�ļ�1','�ļ�2','�ļ�3'};
tic
for i = 1:length(filename)
    dealFile(filename{i});
    figure(i)
    drawVTpic(filename{i});
    fprintf('----------------------\n');
end
fprintf('�����ļ������쳣������ɣ�\n');
toc