<!-- �ҵ�����¼���棬ʹ��session��������ڶ��ҳ���е�����ת������ -->
<%@ page language="java" contentType="text/html; charset=GBK" %>
<html>
<head>
	<title>�ҵ����</title>
</head>

<body>
<%
	session.setAttribute("customer","customer");
%>
����ǰ���ȵ�¼
<form name="login" action="purchaseBook.jsp" method="post">
�û�����
<input type="text" name="customername">
<input type="submit" name="submit" value="��¼">
</form>
</body>
</html>