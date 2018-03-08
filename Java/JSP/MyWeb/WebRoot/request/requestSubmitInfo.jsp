<%@ page contentType="text/html;charset=GB2312" %>
<HTML>
<BODY bgcolor=green><FONT size=2>
<P>文本框中提交的信息为：
<%String textContent=request.getParameter("boy");
%>
<BR>
<%=textContent%>
<P>获取信息的按钮为：
<%String buttonName=request.getParameter("submit");
%>
<BR>
<%=buttonName%>
</FONT>
</BODY>
</HTML>