package bean;
public class Circle
{ int radius;
public Circle() //�޲����Ĺ��캯��
{ radius=1;
}
public int getRadius() //get()����
{ return radius;
}
public void setRadius(int newRadius) //set()����
{radius=newRadius;
}
public double circleArea()
{return Math.PI*radius*radius;
}
public double circlLength()
{return 2.0*Math.PI*radius;
}
}