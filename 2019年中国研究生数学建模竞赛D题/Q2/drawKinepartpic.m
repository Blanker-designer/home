function drawKinepartpic(filename)
set(gcf,'outerposition',get(0,'screensize'))
fprintf('���ڵ���%s�˶�ѧƬ��...\n',filename);
load([filename,'�˶�ѧƬ��'],'kinepart');
for i = 1:4
    subplot(2,2,i)
    data = kinepart{i}; % ��ȡ�˶�ѧƬ��
    plotdata = cell2mat(data(2:end,2));
    plot(plotdata,'r-','linewidth',2)
    grid on
    set(gca,'fontsize',24)
    xlabel('ʱ�䣨s��'),ylabel('���٣�km/h��');
    set(gca,'GridLineStyle','--','GridColor','k','GridAlpha',1)
    text = sprintf('%s - %s',data{2,1},data{end,1}); % Ƭ����ֹʱ��
    axis tight
    title(text) 
end
print(gcf,'-djpeg','-r300',[filename,'ǰ4���˶�ѧƬ��']);
fprintf('%sǰ4���˶�ѧƬ�λ�����ɣ�\n',filename)
end