<%@ page contentType="text/html;charset=GB2312" %>
<HTML>
<BODY>
<%! public class Circle
{double r;
Circle(double r)
{this.r=r;
}
double �����()
{return Math.PI*r*r;
}
double ���ܳ�()
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
 Circle circle=new Circle(r); // ��������%> 
 <P> Բ������ǣ�
  <BR>
   <%=circle. �����()%> 
 <P> Բ���ܳ��ǣ�
  <BR> <%=circle. ���ܳ�()%> 
</BODY> 
</HTML>