function [distance path] = Dijk( W,st,e )
%DIJK Summary of this function goes here
%   W  Ȩֵ����   st ���������   e �������յ�
n=length(W);%Ȩֵ�������������ڵ���
D = W(st,:);%Դ�ڵ����������ڵ�ľ���
visit= ones(1,n); visit(st)=0;%�ڵ��������ʶ����
parent = zeros(1,n);%��¼ÿ���ڵ����һ���ڵ�

path =[];

for i=1:n-1
    temp = 1./zeros(1,n);
    %��������������̾������һ���㣬ÿ�β����ظ�ԭ���Ĺ켣������visit�жϽڵ��Ƿ����
    for j=1:n
       if visit(j)
           temp(j) =D(j);
       end
       
    end
    
    [~,index] = min(temp);%Ϊ�˻��temp����Сֵ����ű�����������ʽ��valueֵ����Ҫ
   
    visit(index) = 0;
    
    %���� �������index�ڵ㣬����㵽ÿ���ڵ��·�����ȸ�С������£���¼ǰ���ڵ㣬����������ѭ��
    for k=1:n
        if D(k)>D(index)+W(index,k)
           D(k) = D(index)+W(index,k);
           parent(k) = index;
        end
    end
    
   
end

distance = D(e);%��̾���
%���ݷ�  ��β����ǰѰ������·��
t = e;
while t~=st && t>0
 path =[t,path];
  p=parent(t);t=p;
end
path =[st,path];%���·��


end
