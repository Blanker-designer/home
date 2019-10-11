% ׼���洢�ռ�
clc,clear,close all

% �ϲ������ļ��˶�ѧƬ��
kinePart = kinePartCombine({'�ļ�1','�ļ�2','�ļ�3'});

% �����˶�ѧ����ָ��
[kineFeature,kineFeature_mat] = calKineFeature(kinePart);
  
% ���ɷַ�����ά(���ۼƹ�����85%����)
[kineFeature_dim,mylatent] = myPCA(kineFeature_mat,0.85);

% K-Means���࣬�۳�����
group =myK_means(kineFeature_dim,3);

% ���������������Ӧ��������
[kinePartSorted,curve] = calCurve2(kinePart,group);

% ����ϳ����ߵ�Ƭ�β���
[sectionSpeed,sectionTime] = calSection(curve,kinePart);

% �ϳɹ�������
curveComposed = calCurveComposed(kinePartSorted,sectionTime,sectionSpeed);

% ��������ָ��������
[CombinFeature_erro_abs,CombinFeature_erro_rel,CombinFeature_erro_mean] = ...
    calCombinFeatureErro(kinePart,curve,curveComposed);

% �ٶ�-���ٶ����ϸ��ʷֲ�������
[VAcombinePro_erro_abs,VAcombinePro_erro_rel,VAcombinePro_erro_mean] = ...
    calVAcombineProErro(kinePart,curve,curveComposed);

% �������յĹ�������
curvename = {'��һ�๤������','�ڶ��๤������','�����๤������','�ϳɹ�������'};
[~,index] = min(CombinFeature_erro_mean+VAcombinePro_erro_mean);
fprintf('������������������㣬��ѵĹ�������Ϊ%s\n',curvename{index});

