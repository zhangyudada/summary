<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="error.jsp"%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"> 
<HTML> 
<HEAD> 
<TITLE>����pageָ���errorPage����</TITLE> 
</HEAD> 
<BODY> 
<% //������뽫��������ʱ�쳣
int a = 6;
int b = 0; 
int c = a / b; 
%>
<%=a %> /<%=b %>=<%=c %>
</BODY> 
</HTML>