%�������PIֵ

clc;
clear all;

%�������Ͷ��ʵ��Ĵ���
Test_num = 1e6;
%��������������1/4Բ�ڵĴ���
Success_num = 0;
%��������1/4Բ�İ뾶��Ҳ�������α߳�
R = 10;

for i = 1:Test_num
    x = unifrnd(0,R);
    y = unifrnd(0,R);
    if sqrt(x*x+y*y) <= R
        Success_num = Success_num + 1;
    end
end

%����PIֵ����Ƶ�ʣ�Success_num/Test_num���������
my_PI = 4*Success_num/Test_num;
fprintf('PI = %d\n', my_PI); 