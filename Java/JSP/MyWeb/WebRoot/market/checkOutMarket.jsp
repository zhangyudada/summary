<%@ page contentType="text/html;charset=GB2312" %>
<%! //�����ַ����ķ�����
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
<% String �˿�=(String)session.getAttribute("customer");
String ����=(String)session.getAttribute("name");
String ��Ʒ=(String)session.getAttribute("goods");
����=getString(����);
��Ʒ=getString(��Ʒ);
%>
<P><%= ����%>�����ã�
<P>����������̨����ѡ��ѡ������Ʒ�ǣ�
<%= ��Ʒ%>
</FONT>
</BODY>
</HTML>