<%@page contentType="text/html;charset=gb2312" errorPage="er.jsp"%>
<html><head><title>exception对象应用实例</title><head>
<body>
<%
int number=10;
try
{
number=Integer.parseInt(request.getParameter("number"));
}
catch(NumberFormatException e)
{
throw new NumberFormatException("您输入的数字不是整数！");
}
%>
<%="您输入的整数是"+number%>
<br>
</body>
</html>