<%@ page language="java" import="java.util.*"%>
<%@ page contentType="text/html;charset=gb2312"%>
<HTML>
<BODY>
<font size="2">
北京时间：（每隔1秒钟自动刷新）<br>
<%
response.setHeader("refresh","1");
out.println(new Date().toLocaleString());
%>
</font>
</BODY>
</HTML>