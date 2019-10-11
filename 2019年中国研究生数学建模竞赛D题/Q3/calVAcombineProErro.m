function [erro_abs,erro_rel,erro_mean] = calVAcombineProErro(kinePart,curve,curveComposed)
kinePart_all = cell2mat(kinePart);
kinePart_all_VAcombinePro = calVAcombinePro(kinePart_all);
curve1_VAcombinePro = calVAcombinePro(curve{1});
curve2_VAcombinePro = calVAcombinePro(curve{2});
curve3_VAcombinePro = calVAcombinePro(curve{3});
curveComposed_VAcombinePro = calVAcombinePro(curveComposed);

curve_VAcombinePro = {...
    curve1_VAcombinePro,...
    curve2_VAcombinePro,...
    curve3_VAcombinePro,...
    curveComposed_VAcombinePro
    };

% ����������
for i = 1:4
    erro_abs{i} = curve_VAcombinePro{i} - kinePart_all_VAcombinePro;
    erro_rel_temp = abs(curve_VAcombinePro{i} - kinePart_all_VAcombinePro)./...
        abs(kinePart_all_VAcombinePro);
    erro_rel_temp(isnan(erro_rel_temp)) = 0;
    erro_rel{i} = erro_rel_temp;
    erro_mean(i) = mean(mean(erro_rel{i}));
end

[~,index]= min(erro_mean);

figure;
set(gcf,'outerposition',get(0,'screensize'))
groupName = {'��һ�๤��','�ڶ��๤��','�����๤��','�ϳɹ���'};
for i = 1:4
    subplot(2,2,i)
    surf(curve_VAcombinePro{i})
    xlabel('���ٶ�(m/s^2)'),ylabel('�ٶ�(km/h)'),zlabel('����');
    if i == index
        title([groupName{i},'�������С������']);
    else
        title(groupName{i});
    end
    grid on
    set(gca,'GridLineStyle','--','GridColor','k','GridAlpha',1,'fontsize',24,...
        'xtick',1:2:8,'xticklabel',-3:2:3,'ytick',1:2:8,'yticklabel',0:20:80);
    axis tight
end
print(gcf,'-djpeg','-r300','���๤���ٶ�-���ٶȸ��ʷֲ�ͼ');

figure;
set(gcf,'outerposition',get(0,'screensize'))
surf(kinePart_all_VAcombinePro)
xlabel('���ٶ�(m/s^2)'),ylabel('�ٶ�(km/h)'),zlabel('����');
title('ԭʼ����');
grid on
set(gca,'GridLineStyle','--','GridColor','k','GridAlpha',1,'fontsize',24,...
    'xtick',1:8,'xticklabel',-3:1:3,'ytick',1:8,'yticklabel',0:10:80);
axis tight
print(gcf,'-djpeg','-r300','ԭʼ�����ٶ�-���ٶȸ��ʷֲ�ͼ');

fprintf('%s������ɣ�\n','�ٶ�-���ٶ����ϸ��ʷֲ�������')
end