function [erro_abs,erro_rel,erro_mean] = calCombinFeatureErro(kinePart,curve,curveComposed)
% ���������˶�ѧƬ�ε���������ָ��
[~,combinFeature_mat] = calCombinFeature (kinePart);
combinFeature_all = mean(combinFeature_mat);   % ȡ��ֵ

% �������й���������������ָ��
curve_all = [curve,{curveComposed}];
[~,combinFeature_curve] = calCombinFeature(curve_all); 

% ����������
erro_abs = combinFeature_curve - combinFeature_all;
erro_rel = abs(erro_abs)./abs(combinFeature_all);
erro_mean = mean(erro_rel');
name = {'��һ�๤������','�ڶ��๤������','�����๤������','�ϳɹ�������'};
[~,index]= min(erro_mean);

figure;set(gcf,'outerposition',get(0,'screensize'))

subplot(2,1,1)
plot(1:11,combinFeature_all,'ro-',1:11,combinFeature_curve(index,:),'bo-','linewidth',2);
xlabel('����ָ��'),ylabel('ָ��ȡֵ'); legend({'ʵ�ʹ���',[name{index},'(�����С����)']})
set(gca,'GridLineStyle','--','GridColor','k','GridAlpha',1,'fontsize',24);
grid on ,axis tight

subplot(2,1,2)
plot(1:11,erro_rel(index,:),'bo-','linewidth',2);
xlabel('����ָ��'),ylabel('������');
set(gca,'GridLineStyle','--','GridColor','k','GridAlpha',1,'fontsize',24);
grid on ,axis tight

print(gcf,'-djpeg','-r300','������������ָ��������');
fprintf('%s������ɣ�\n','������������ָ��������')

end
