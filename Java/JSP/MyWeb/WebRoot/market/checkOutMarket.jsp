<%@ page contentType="text/html;charset=GB2312" %>
<%! //处理字符串的方法：
public String getString(String s)
{ if(s==null)
{s="";
} try {byte b[]=s.getBytes("ISO-8859-1");
s=new String(b);
}
catch(Exception e)
{
}
return s;
}
%>
<HTML>
<BODY bgcolor=cyan><FONT Size=2>
<% String s=request.getParameter("buy");
session.setAttribute("goods",s);
%>
<BR>
<% String 顾客=(String)session.getAttribute("customer");
String 姓名=(String)session.getAttribute("name");
String 商品=(String)session.getAttribute("goods");
姓名=getString(姓名);
商品=getString(商品);
%>
<P><%= 姓名%>，您好！
<P>这里是收银台，您选择选购的商品是：
<%= 商品%>
</FONT>
</BODY>
</HTML>