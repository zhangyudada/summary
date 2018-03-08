<%@ page contentType="text/html;charset=GB2312" %>
<HTML>
<BODY>
<% String str=null;
str=request.getParameter("boy");
if(str==null)
{str="";
}
byte b[]=str.getBytes("ISO-8859-1");
str=new String(b);
if(str.equals(""))
{response.sendRedirect("login.jsp");
}
else
{out.print(str+"£¬»¶Ó­·ÃÎÊ±¾Õ¾£¡");
}
%>
</BODY>
</HTML>