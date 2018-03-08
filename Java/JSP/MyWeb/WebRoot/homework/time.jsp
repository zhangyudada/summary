<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*"%>
<html>
<body>

<%
	//使用response方法的setHeader()方法完成页面刷新功能
	response.setHeader("refresh","1");
%>
北京时间（每隔一秒自动刷新）
<%out.print(new Date().toLocaleString());%>
</body>
</html>