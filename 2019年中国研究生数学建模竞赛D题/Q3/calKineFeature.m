function [kineFeature,kineFeature_mat] = calKineFeature(kinePart)
% ����洢����ֵ�Ľṹ��
kineFeature = struct(...
    'run_time',{},...           % ����ʱ��
    'neglect_time',{},...       % ����ʱ��
    'accelerate_time',{},...    % ����ʱ��
    'slowdown_time',{},...      % ����ʱ��
    'unispeed_time',{},...      % ����ʱ��
    'av_speed',{},...           % ƽ���ٶ�
    'av_runspeed',{},...        % ƽ����ʻ�ٶ�
    'max_speed',{},...          % ����ٶ�
    'speed_std',{},...          % �ٶȱ�׼��
    'av_accelerate',{},...      % ƽ�����ٶ�
    'max_accelerate',{},...     % �����ٶ�
    'accelerate_std',{},...     % ���ٶȱ�׼��
    'av_slowdown',{},...        % ƽ�����ٶ�
    'min_slowdown',{},...       % ��С���ٶ�
    'slowdown_std',{});         % ���ٶȱ�׼��

m = length(kinePart);

for i = 1:m
    % ��ȡ�ٶ�
    data_temp = kinePart{i};
    v_delta =  (data_temp(2:end) - data_temp(1:end-1)); % �����ٶȲ�
    
    % �����˶�������ֵ
    % ʱ������ֵ ��λ��s
    kineFeature(i).run_time = length( data_temp)-1;                         % ��������ʱ��
    kineFeature(i).neglect_time = sum(v_delta == 0);                        % ���㵡��ʱ��
    kineFeature(i).accelerate_time = sum( v_delta > 0.1*3600/1000);         % �������ʱ��
    kineFeature(i).slowdown_time = sum( v_delta < -0.1*3600/1000);          % �������ʱ��
    kineFeature(i).unispeed_time = sum( v_delta >= -0.1*3600/1000 &...
        v_delta <= 0.1*3600/1000 & v_delta ~= 0);                           % ��������ʱ��
    
    % �ٶ�����ֵ ��λ��km/h
    kineFeature(i).av_speed = mean(data_temp);                              % ����ƽ���ٶ�
    kineFeature(i).av_runspeed = mean(data_temp(data_temp~=0));             % ����ƽ����ʻ�ٶ�
    kineFeature(i).max_speed = max(data_temp);                              % ��������ٶ�
    kineFeature(i).speed_std = std(data_temp);                              % �����ٶȱ�׼��
    
    % ���ٶ�����ֵ ��λ��m/s^2
    v_delta2 = v_delta*1000/3600; %��λ����
    kineFeature(i).av_accelerate = mean(v_delta2(v_delta2 > 0.1));          % ����ƽ�����ٶ�
    kineFeature(i).max_accelerate = max(v_delta2(v_delta2 > 0.1));          % ���������ٶ�
    kineFeature(i).accelerate_std = std(v_delta2(v_delta2 > 0.1));          % ������ٶȱ�׼��
    
    kineFeature(i).av_slowdown = mean(v_delta2(v_delta2 < -0.1));           % ����ƽ�����ٶ�
    kineFeature(i).min_slowdown = max(v_delta2(v_delta2 < -0.1));           % ������С���ٶ�
    kineFeature(i).slowdown_std = std(v_delta2(v_delta2 < -0.1));           % ������ٶȱ�׼��
    
end
kineFeature_mat = cell2mat(reshape(struct2cell(kineFeature),15,length(kineFeature))');     % �˶�ѧ����ָ��ת����洢
fprintf('�˶�ѧ����ָ�������ɣ�\n');
end
