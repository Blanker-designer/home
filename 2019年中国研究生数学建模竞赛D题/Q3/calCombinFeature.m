function [combinFeature,combinFeature_mat] = calCombinFeature (kinepart)
% ����洢����ֵ�Ľṹ��
combinFeature = struct(...
    'av_speed',{},...           % ƽ���ٶ�
    'av_runspeed',{},...        % ƽ����ʻ�ٶ�
...  %     'max_speed',{},...          % ����ٶ�
    'speed_std',{},...          % �ٶȱ�׼��
    'av_accelerate',{},...      % ƽ�����ٶ�
    'accelerate_std',{},...     % ���ٶȱ�׼��
    'av_slowdown',{},...        % ƽ�����ٶ�
    'slowdown_std',{},...       % ���ٶȱ�׼��
    'neglect_time',{},...       % ����ʱ��
    'accelerate_time',{},...    % ����ʱ��
    'slowdown_time',{},...      % ����ʱ��
    'unispeed_time',{});        % ����ʱ��
m = length(kinepart);

for i = 1:m
    % ��ȡ�ٶ�
    data_temp = kinepart{i};
    v_delta =  (data_temp(2:end) - data_temp(1:end-1)); % �����ٶȲ�
    
    combinFeature(i).av_speed = mean(data_temp);                            % ����ƽ���ٶ�
    combinFeature(i).av_runspeed = mean(data_temp(data_temp~=0));           % ����ƽ����ʻ�ٶ�
%     combinFeature(i).max_speed = max(data_temp);                            % ��������ٶ�
    combinFeature(i).speed_std = std(data_temp);                            % �����ٶȱ�׼��
    
    % ���ٶ�����ֵ ��λ��m/s^2
    v_delta2 = v_delta*1000/3600; %��λ����
    combinFeature(i).av_accelerate = mean(v_delta2(v_delta2 > 0.1));        % ����ƽ�����ٶ�
    combinFeature(i).accelerate_std = std(v_delta2(v_delta2 > 0.1));        % ������ٶȱ�׼��
    combinFeature(i).av_slowdown = mean(v_delta2(v_delta2 < -0.1));         % ����ƽ�����ٶ�
    combinFeature(i).slowdown_std = std(v_delta2(v_delta2 < -0.1));         % ������ٶȱ�׼��
    
    combinFeature(i).neglect_time =  sum(v_delta == 0)/(length( data_temp)-1);% ���㵡��ʱ���
    combinFeature(i).accelerate_time =  sum( v_delta > 0.1*3600/1000)/...
        (length( data_temp)-1);                                             % �������ʱ���
    combinFeature(i).slowdown_time =  sum( v_delta < -0.1*3600/1000)/...
        (length( data_temp)-1);                                             % �������ʱ���
    combinFeature(i).unispeed_time =  sum( v_delta >= -0.1*3600/1000 & ...
        v_delta <= 0.1*3600/1000 & v_delta ~= 0)/(length( data_temp)-1);     % ��������ʱ���
    
end
combinFeature_mat = cell2mat(reshape(struct2cell(combinFeature),11,length(combinFeature))');     % ����ֲ�����ָ��ת����洢
end
