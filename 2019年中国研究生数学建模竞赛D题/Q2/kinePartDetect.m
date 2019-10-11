function kinepart = kinePartDetect(data)
datanew = data;
% ��ȡ�ٶ�
data_temp = cell2mat(datanew(2:end,2));
fprintf('���ڲ����˶�ѧƬ��...\n')
% �ҳ��ٶȴ���0������
v_index = find(data_temp(:,1)>0);
% �ҳ�������Ƭ��
deal_index1 = is_continue(v_index);
% ͳ������Ƭ�γ���
for i = 1:length(deal_index1)
    index1_length(i) = length(deal_index1{i});
end
% �ҳ�����10s�����ݶ�
deal_index2 = deal_index1(index1_length > 10,1);
% �ҳ�ǰ��Ϊ0�ģ�����Ҫ����˶�Ƭ��
is_part = zeros(length(deal_index2),1);
for i = 1:length(deal_index2)
    part_start = deal_index2{i,1}(1)-1;
    part_end = deal_index2{i,1}(end)+1;
    if (data_temp(part_start)==0) && (data_temp(part_end)==0)
        is_part(i) = 1;
    end
end
deal_index3 = deal_index2(is_part==1,1);
kinepart = cell(length(deal_index3),1);
% �ҳ�ǰ��180s��Χ��Ϊ0����һ��
for j = 1:length(deal_index3)
    for k = 1:180
        if deal_index3{j,1}(1)-k > 1  %�����Գ�������
            if data_temp(deal_index3{j,1}(1)-k) ~= 0 
                break;
            end
        else
            break;
        end
    end
    now_index = (deal_index3{j,1}(1)-k+1:deal_index3{j,1}(end)+1);
    kinepart{j,1} = datanew([1,now_index+1],:);
end
fprintf('һ���ҵ�%d���˶�ѧƬ�Σ�\n',length(deal_index3));
end