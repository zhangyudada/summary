<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*"%>
<html>
<body>

<%
	//ʹ��response������setHeader()�������ҳ��ˢ�¹���
	response.setHeader("refresh","1");
%>
����ʱ�䣨ÿ��һ���Զ�ˢ�£�
<%out.print(new Date().toLocaleString());%>
</body>
</html>