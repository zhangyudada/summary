<%@ page language="java" import="java.util.*"%>
<%@ page contentType="text/html;charset=gb2312"%>
<HTML>
<BODY>
<font size="2">
����ʱ�䣺��ÿ��1�����Զ�ˢ�£�<br>
<%
response.setHeader("refresh","1");
out.println(new Date().toLocaleString());
%>
</font>
</BODY>
</HTML>