function df_A  = mygreedy(time,n_workshop_A,time_cost_A,n_car)
M = 10000;
is_finish_A = zeros(1,n_car); % ��¼���ж����Ĺ������״̬��1Ϊ��ɣ�0Ϊδ���
is_work_A = zeros(M,n_workshop_A); % ��¼����ʱ�̳����ռ�����
input_time_record_A = []; % ��¼������վʱ��
output_time_record_A = []; % ��¼������սʱ��
workshop_ind_record_A = []; % ��¼���޳�����
n_arrival_car_A = 0; % ��¼������ĳ�����
for time_A = 1:length(time)
    num_work_A = sum(is_work_A(time(time_A),:)); %����timeʱ�̵ĳ�����������
    num_finish_A = sum(is_finish_A); % ����timeʱ���Ѿ�����������
    %����ȫ������ �� ���г��Ѿ���ɼ���
    if num_work_A == 0 && num_finish_A == n_car
        break
    else
        if num_work_A < n_workshop_A && num_finish_A < n_car
            [~,col] = find(is_work_A(time(time_A),:) == 0);
            free_id = col(1);
            is_work_A(time(time_A):time(time_A)+time_cost_A-1,free_id) = 1;
            is_finish_A(1,n_arrival_car_A+1) = 1;
            n_arrival_car_A = n_arrival_car_A + 1;
            output_time_record_A = [output_time_record_A,time(time_A) - 1 + time_cost_A];
            input_time_record_A = [input_time_record_A,time(time_A) - 1];
            workshop_ind_record_A = [ workshop_ind_record_A ,free_id];
    end
    end
end
 % ������浽�ṹ����
 for i = 1:length(input_time_record_A)
     df_A(i).input_time = input_time_record_A(i);
     df_A(i).output_time = output_time_record_A(i);
     df_A(i).repair_time =output_time_record_A(i) - input_time_record_A(i);
     df_A(i).workshop_ind = workshop_ind_record_A(i);
 end