%% ׼���洢�ռ�
clc , clear , close all;

%% ������ʼ��

[~,~,time ]= xlsread('�г���Ϣ.xlsx','�г�ʱ�̱�');
[~,~,time_cost ]= xlsread('�г���Ϣ.xlsx','�г����޺�ʱ��');
[~,~,rank ]= xlsread('�г���Ϣ.xlsx','���޵ȼ�');

train_time = cell2mat(time(2:end,2)); % �г�����ʱ��
train_id = cell2mat(time(2:end,4)); % �г����
train_rank = cell2mat(time(2:end,6));% �г���������
time_cost = cell2mat(time_cost(2:end,2:end))*60; % �г����޺�ʱ
rank = cell2mat(rank(2:end,2:end)); % �������ͼ���·��


% ��������޺�ʱ����λ��1���ӣ�

time_cost_A = time_cost(train_id,1).*rank(train_rank,1);
time_cost_B = time_cost(train_id,2).*rank(train_rank,2);
time_cost_C = time_cost(train_id,3).*rank(train_rank,3);
time_cost_D = time_cost(train_id,4).*rank(train_rank,4);
time_cost_E = time_cost(train_id,5).*rank(train_rank,5);


n_car = length(train_time); % ������޳�����

% �����򳵼���
n_workshop_A = 3;
n_workshop_B = 8;
n_workshop_C = 5;
n_workshop_D = 3;
n_workshop_E = 2;

%% ���� A ����ļ������
df_A = mygreedy3(train_time,n_workshop_A,time_cost_A,n_car,1:n_car);

%% ���� B ����ļ������
df_B = mygreedy3(cat(1,df_A.output_time),n_workshop_B,time_cost_B,n_car,cat(1,df_A.out_ind));

%% ���� C ����ļ������
df_C = mygreedy3(cat(1,df_B.output_time),n_workshop_C,time_cost_C,n_car,cat(1,df_B.out_ind));

%% ���� D ����ļ������
df_D = mygreedy3(cat(1,df_C.output_time),n_workshop_D,time_cost_D,n_car,cat(1,df_C.out_ind));

%% ���� E ����ļ������
df_E = mygreedy3(cat(1,df_D.output_time),n_workshop_E,time_cost_E,n_car,cat(1,df_D.out_ind));

%% ������г�����ʱ��
clear R
for i = 1:n_car
    R(i).A= df_A([df_A.out_ind]==i);
    R(i).B= df_B([df_B.out_ind]==i);
    R(i).C= df_C([df_C.out_ind]==i);
    R(i).D= df_D([df_D.out_ind]==i);
    R(i).E= df_E([df_E.out_ind]==i);
end

%% ������
time_max = max (cat(1,df_E.output_time));
time_min = min (cat(1,df_A.input_time));
fprintf('�г�ȫ�����������Ҫ%d���ӣ���ʱΪ  %s\n',time_max - time_min,min2time(time_max));

%% �����г��Ľ���վʱ�̱�
for i = 1:n_car+1
    if i == 1
        train_io{i,1} = '�г����';
        train_io{i,2} = 'A�����վʱ��';
        train_io{i,3} = 'A�����վʱ��';
        train_io{i,4} = 'B�����վʱ��';
        train_io{i,5} = 'B�����վʱ��';
        train_io{i,6} = 'C�����վʱ��';
        train_io{i,7} = 'C�����վʱ��';
        train_io{i,8} = 'D�����վʱ��';
        train_io{i,9} = 'D�����վʱ��';
        train_io{i,10} = 'E�����վʱ��';
        train_io{i,11} = 'E�����վʱ��';
    else
        train_io{i,1}= sprintf('R%d',i-1);
        train_io{i,2} =min2time(R(i-1).A.input_time);
        train_io{i,3} =min2time(R(i-1).A.output_time);
        train_io{i,4} =min2time(R(i-1).B.input_time);
        train_io{i,5} =min2time(R(i-1).B.output_time);
        train_io{i,6} =min2time(R(i-1).C.input_time);
        train_io{i,7} =min2time(R(i-1).C.output_time);
        train_io{i,8} =min2time(R(i-1).D.input_time);
        train_io{i,9} =min2time(R(i-1).D.output_time);
        train_io{i,10} =min2time(R(i-1).E.input_time);
        train_io{i,11} =min2time(R(i-1).E.output_time);
    end
end
xlswrite('�г�����վʱ�̱�',train_io,'Sheet1')
%% ������ͼ
figure;
set(gcf,'outerposition',get(0,'screensize'));
for i = 1:n_car
    rectangle('position',[(R(i).A.input_time) , (R(i).A.workshop_ind-1), (R(i).A.repair_time) ,1]...
        ,'linewidth',0.5,'facecolor',[146,208,80]/255)
    text( (R(i).A.input_time+R(i).A.repair_time/4) , (R(i).A.workshop_ind-1+0.5) , sprintf('R%d-A%d',i,R(i).A.workshop_ind))
    
    rectangle('position',[(R(i).B.input_time) , (R(i).B.workshop_ind + 3 -1), ...
        (R(i).B.repair_time) , 1 ],'linewidth',0.5,'facecolor',[0,176,240]/255)
    text( (R(i).B.input_time+R(i).B.repair_time/4) , (R(i).B.workshop_ind-1 + 3 +0.5) , sprintf('R%d-B%d',i,R(i).B.workshop_ind))
    
    rectangle('position',[(R(i).C.input_time) , (R(i).C.workshop_ind + 3+ 5  -1) , ...
        (R(i).C.repair_time) , 1 ],'linewidth',0.5,'facecolor',[255,192,0]/255)
    text((R(i).C.input_time+R(i).C.repair_time/4) , (R(i).C.workshop_ind-1 + 3 + 5  +0.5) ,sprintf('R%d-C%d',i,R(i).C.workshop_ind))
    
    rectangle('position',[(R(i).D.input_time) , (R(i).D.workshop_ind + 3+5+3  -1) , ...
        (R(i).D.repair_time) , 1 ],'linewidth',0.5,'facecolor',[198,89,17]/255)
    text((R(i).D.input_time+R(i).D.repair_time/4) , (R(i).D.workshop_ind-1 + +3+5+3  +0.5) ,sprintf('R%d-D%d',i,R(i).D.workshop_ind))
    
    rectangle('position',[(R(i).E.input_time) , (R(i).E.workshop_ind + 3+5+3+3 -1 ) , ...
        (R(i).E.repair_time) , 1 ],'linewidth',0.5,'facecolor',[112,48,160]/255)
    text((R(i).E.input_time+R(i).E.repair_time/4) , (R(i).E.workshop_ind-1 + 3+5+3+3  +0.5) ,sprintf('R%d-E%d',i,R(i).E.workshop_ind))
    
end
workname = {'',...
    '����A-����1','����A-����2','����A-����3',...
    '����B-����1','����B-����2','����B-����3','����B-����4','����B-����5',...
    '����C-����1','����C-����2','����C-����3',...
    '����D-����1','����D-����2','����D-����3',...
    '����E-����1','����E-����2','����E-����3'
    };
xlabel('ʱ�䣨��λ��1���ӣ�')
set(gca,'xtick',0:60:1200,'ytick',[0,0.5:16.5],'yticklabel',workname,'fontsize',24)

saveas(gcf,'�������г����޸���ͼ.tif')