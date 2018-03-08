%用于画二维圆的函数，输入参数为圆心坐标(x,y)和半径r，输出为圆形
function circle(x,y,r)

    plot(x,y,'+k');
    hold on;
    grid on;
    rectangle('Position',[x-r,y-r,2*r,2*r],'Curvature',[1,1]);
    axis equal;

end
