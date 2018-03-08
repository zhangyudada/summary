<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="error.jsp"%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"> 
<HTML> 
<HEAD> 
<TITLE>测试page指令的errorPage属性</TITLE> 
</HEAD> 
<BODY> 
<% //下面代码将出现运行时异常
int a = 6;
int b = 0; 
int c = a / b; 
%>
<%=a %> /<%=b %>=<%=c %>
</BODY> 
</HTML>