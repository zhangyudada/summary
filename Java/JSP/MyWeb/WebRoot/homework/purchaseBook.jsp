<%@ page language="java" contentType="text/html; charset=GBK" %>
<html>
<head>
	<title>选购图书</title>
</head>

<body>
<%
	//使用session对象完成在多个页面中的数据转发功能
	String cus=request.getParameter("customername");
	//如果未输入用户名，就使用<jsp:forward>动作元素跳转到出错界面，并不再执行当前页面
	if(cus.equals("")){
		%>
		<jsp:forward page="bookError.jsp" ></jsp:forward>
		<%
	}	
	session.setAttribute("name",cus);
%>
请选择您要买的书
<form name="buy" action="checkOutBook.jsp" method="post">
<!-- 选择列表，选择需要购买的图书，默认选中“信息网络应用基础” -->
<select name="books">
	<option value="通信原理">通信原理</option>
	<option value="数据库">数据库</option>
	<option value="信息网络应用基础" selected="selected">信息网络应用基础</option>
	<option value="信号与系统">信号与系统</option>
</select>
<input type="submit" name="submit" value="确定">
</form>
</body>
</html>