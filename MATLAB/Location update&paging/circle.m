%���ڻ���άԲ�ĺ������������ΪԲ������(x,y)�Ͱ뾶r�����ΪԲ��
function circle(x,y,r)

    plot(x,y,'+k');
    hold on;
    grid on;
    rectangle('Position',[x-r,y-r,2*r,2*r],'Curvature',[1,1]);
    axis equal;

end
