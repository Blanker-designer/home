function [distFeature,distFeature_mat ]= calDistFeature(kinePart)

% ����ִ洢�ֲ������Ľṹ��
distFeature =  struct(...
    'neglect_time',{}, ...      % ����ʱ���
    'accelerate_time',{}, ...   % ����ʱ���
    'slowdown_time',{},...      % ����ʱ���
    'unispeed_time',{},...      % ����ʱ���
    'v0_10_time',{},...         % 0-10km �ٶȶα���
    'v10_20_time',{},...        % 10-20km �ٶȶα���
    'v20_30_time',{},...        % 20-30km �ٶȶα���
    'v30_40_time',{},...        % 30-40km �ٶȶα���
    'v40_50_time',{},...        % 40-50km �ٶȶα���
    'v50_60_time',{},...        % 50-60km �ٶȶα���
    'v60_70_time',{},...        % 60-70km �ٶȶα���
    'v70_inf_time',{});         % 70-infkm �ٶȶα���


m = length(kinePart);

for i = 1:m
    % ��ȡ�ٶ�
    data_temp = kinePart{i};
    v_delta =  (data_temp(2:end) - data_temp(1:end-1)); % �����ٶȲ�
    
    % �����˶�������ֲ�����
    distFeature(i).neglect_time =  sum(v_delta == 0)/(length( data_temp)-1);    % ���㵡��ʱ���
    distFeature(i).accelerate_time =  sum( v_delta > 0.1*3600/1000)/...
        (length( data_temp)-1);                                                 % �������ʱ���
    distFeature(i).slowdown_time =  sum( v_delta < -0.1*3600/1000)/...
        (length( data_temp)-1);                                                 % �������ʱ���
    distFeature(i).unispeed_time =  sum( v_delta >= -0.1*3600/1000 & ...
        v_delta <= 0.1*3600/1000 & v_delta ~= 0)/(length( data_temp)-1);        % �������ʱ���
    distFeature(i).v0_10_time =  sum(data_temp>0 & data_temp<=10)/...
        (sum( data_temp>0));                                                    % 0-10km �ٶȶα���
    distFeature(i).v10_20_time =  sum(data_temp>10 & data_temp<=20)/...
        (sum( data_temp>0));                                                    % 10-20km �ٶȶα���
    distFeature(i).v20_30_time =  sum(data_temp>20 & data_temp<=30)/...
        (sum( data_temp>0));                                                    % 20-30km �ٶȶα���
    distFeature(i).v30_40_time =  sum(data_temp>30 & data_temp<=40)/...
        (sum( data_temp>0));                                                    % 30-40km �ٶȶα���
    distFeature(i).v40_50_time =  sum(data_temp>40 & data_temp<=50)/...
        (sum( data_temp>0));                                                    % 40-50km �ٶȶα���
    distFeature(i).v50_60_time =  sum(data_temp>50 & data_temp<=60)/...
        (sum( data_temp>0));                                                    % 50-60km �ٶȶα���
    distFeature(i).v60_70_time =  sum(data_temp>60 & data_temp<=70)/...
        (sum( data_temp>0));                                                    % 60-70km �ٶȶα���
    distFeature(i).v70_inf_time =  sum(data_temp>70)/(sum( data_temp)-1);       % 70-infkm �ٶȶα���
end
distFeature_mat = cell2mat(reshape(struct2cell(distFeature),12,length(distFeature))');     % ����ֲ�����ָ��ת����洢
end
