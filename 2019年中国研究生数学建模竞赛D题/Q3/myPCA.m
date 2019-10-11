function [data2,mylatent] = myPCA(data,proportion)

% ���ݱ�׼��
data1 = zscore(data);

% ���ɷַ���
[coeff,~,latent] = pca(data1);

% �����ۼƹ����ʣ�ȷ��ά��
latent = latent/sum(latent);
sum_latent = cumsum(latent); % �ۼƹ�����
dimension = find(sum_latent>proportion);
dimension= dimension(1);

% ��ά
data2 = data1  * coeff(:,1:dimension);
mylatent = [latent,sum_latent];% ������  �ۼƹ�����

% ����ʯͼ
figure;
set(gcf,'outerposition',get(0,'screensize'))
plot(mylatent(:,1),'bo-','linewidth',2)
xlabel('���ɷ����'),ylabel('������')
grid on
set(gca,'GridLineStyle','--','GridColor','k','GridAlpha',1,'fontsize',24);
print(gcf,'-djpeg','-r300','���ɷַ�����ʯͼ');

fprintf('���ɷַ�����ά������ɣ�\n');

end