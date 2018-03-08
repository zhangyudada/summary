<!-- 我的书店登录界面，使用session对象完成在多个页面中的数据转发功能 -->
<%@ page language="java" contentType="text/html; charset=GBK" %>
<html>
<head>
	<title>我的书店</title>
</head>

<body>
<%
	session.setAttribute("customer","customer");
%>
购书前请先登录
<form name="login" action="purchaseBook.jsp" method="post">
用户名：
<input type="text" name="customername">
<input type="submit" name="submit" value="登录">
</form>
</body>
</html>