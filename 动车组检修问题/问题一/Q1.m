%% ׼���洢�ռ�
clc , clear , close all;

%% ������ʼ��

n_car = 12*60/15; % 12Сʱ����Ҫ���� 48 ������

% �����򳵼���
n_workshop_A = 3;
n_workshop_B = 8;
n_workshop_C = 5;

% ��������޺�ʱ����λ��15���ӣ�
time_cost_A = 4;
time_cost_B = 8;
time_cost_C = 6;

%% ���� A ����ļ������
time = 1:10000;
df_A = mygreedy(time,n_workshop_A,time_cost_A,n_car);

%% ���� B ����ļ������
df_B = mygreedy(cat(1,df_A.output_time)+1,n_workshop_B,time_cost_B,n_car);

%% ���� C ����ļ������
df_C = mygreedy(cat(1,df_B.output_time)+1,n_workshop_C,time_cost_C,n_car);

%% ������
time_max = max (cat(1,df_C.output_time))*15/60;
fprintf('�г�ȫ�����������Ҫ%d��Сʱ,��ʱʱ��Ϊ%s(������0����ʼ����)\n',time_max,min2time(max (cat(1,df_C.output_time))*15));

%% ���г����޸���ͼ
figure;
set(gcf,'outerposition',get(0,'screensize'));
for i = 1:n_car
    rectangle('position',[(df_A(i).input_time) , (df_A(i).workshop_ind-1), (time_cost_A) ,1]...
    ,'linewidth',0.5,'facecolor',[146,208,80]/255)
    text( (df_A(i).input_time+time_cost_A/4) , (df_A(i).workshop_ind-1+0.5) , sprintf('R%d-A%d',i,df_A(i).workshop_ind))
    
    rectangle('position',[(df_B(i).input_time) , (df_B(i).workshop_ind + n_workshop_A -1), ...
        (time_cost_B) , 1 ],'linewidth',0.5,'facecolor',[0,176,240]/255)
    text( (df_B(i).input_time+time_cost_B/4) , (df_B(i).workshop_ind-1 + n_workshop_A +0.5) , sprintf('R%d-B%d',i,df_B(i).workshop_ind))
    
    rectangle('position',[(df_C(i).input_time) , (df_C(i).workshop_ind + n_workshop_A + n_workshop_B -2 -1) , ...
        (time_cost_C) , 1 ],'linewidth',0.5,'facecolor',[255,192,0]/255)
    text((df_C(i).input_time+time_cost_C/4) , (df_C(i).workshop_ind-1 + n_workshop_A + n_workshop_B-2 +0.5) ,sprintf('R%d-C%d',i,df_C(i).workshop_ind))
end

workname = {'',...
    '����A-����1','����A-����2','����A-����3',...
    '����B-����1','����B-����2','����B-����3','����B-����4','����B-����5','����B-����6'...
    '����C-����1','����C-����2','����C-����3','����C-����4','����C-����5'...
    };
xlabel('ʱ�䣨��λ��15���ӣ�')
set(gca,'xtick',0:4:81,'ytick',[0,0.5:1:14],'yticklabel',workname,'fontsize',24)
saveas(gcf,'����һ�г����޸���ͼ.tif')

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
    else
        train_io{i,1}= sprintf('R%d',i-1);
        train_io{i,2} = min2time (df_A(i-1).input_time*15);
        train_io{i,3} = min2time (df_A(i-1).output_time*15);
        train_io{i,4} = min2time (df_B(i-1).input_time*15);
        train_io{i,5} = min2time (df_B(i-1).output_time*15);
        train_io{i,6} = min2time (df_C(i-1).input_time*15);
        train_io{i,7} = min2time (df_C(i-1).output_time*15);
    end
end

xlswrite('�г�����վʱ�̱�',train_io,'Sheet1')