<%@page contentType="text/html;charset=gb2312" errorPage="er.jsp"%>
<html><head><title>exception����Ӧ��ʵ��</title><head>
<body>
<%
int number=10;
try
{
number=Integer.parseInt(request.getParameter("number"));
}
catch(NumberFormatException e)
{
throw new NumberFormatException("����������ֲ���������");
}
%>
<%="�������������"+number%>
<br>
</body>
</html>