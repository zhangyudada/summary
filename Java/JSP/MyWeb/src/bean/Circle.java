package bean;
public class Circle
{ int radius;
public Circle() //无参数的构造函数
{ radius=1;
}
public int getRadius() //get()方法
{ return radius;
}
public void setRadius(int newRadius) //set()方法
{radius=newRadius;
}
public double circleArea()
{return Math.PI*radius*radius;
}
public double circlLength()
{return 2.0*Math.PI*radius;
}
}