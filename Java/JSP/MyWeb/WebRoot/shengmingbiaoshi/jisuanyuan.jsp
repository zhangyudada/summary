<%@ page contentType="text/html;charset=GB2312" %>
<HTML>
<BODY>
<%! public class Circle
{double r;
Circle(double r)
{this.r=r;
}
double 求面积()
{return Math.PI*r*r;
}
double 求周长()
{return Math.PI*2*r;
}
}
%>
<% String str=request.getParameter("cat"); 
double r; 
if(str!=null)
{r=Double.valueOf(str).doubleValue(); }
else 
{r=1; } 
 Circle circle=new Circle(r); // 创建对象。%> 
 <P> 圆的面积是：
  <BR>
   <%=circle. 求面积()%> 
 <P> 圆的周长是：
  <BR> <%=circle. 求周长()%> 
</BODY> 
</HTML>