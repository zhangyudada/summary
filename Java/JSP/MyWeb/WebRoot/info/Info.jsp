<%@ page contentType="text/html; charset=gb2312" language="java" %> 
<!-- 指定info信息--> 
<%@ page info="this is a jsp"%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"> 
<HTML> 
<HEAD> 
<TITLE>测试page指令的info属性</TITLE> 
</HEAD> 
<BODY> 
<!-- 输出info信息--> 
<%=getServletInfo()%> 
</BODY> 
</HTML>