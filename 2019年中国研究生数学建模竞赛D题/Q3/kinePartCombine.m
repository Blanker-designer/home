function kinePart = kinePartCombine(filename)
% ��������
kinePart ={};
for i = 1:length(filename)
    fprintf('���ڵ���%s�˶�ѧƬ��...\n',filename{i});
    load([filename{i},'�˶�ѧƬ��'],'kinepart');
    m = length(kinepart);
    for j = 1:m
        datatemp = cell2mat(kinepart{j,1}(2:end,2));
        kinePart{end+1,1} = datatemp;
    end
end
fprintf('�����ļ��˶�ѧƬ����ȡ�ϲ���ɣ�\n');
end

