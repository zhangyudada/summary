<%@ page contentType="text/html;charset=GB2312" %>
<HTML>
<BODY bgcolor=green><FONT size=2>
<P>�ı������ύ����ϢΪ��
<%String textContent=request.getParameter("boy");
%>
<BR>
<%=textContent%>
<P>��ȡ��Ϣ�İ�ťΪ��
<%String buttonName=request.getParameter("submit");
%>
<BR>
<%=buttonName%>
</FONT>
</BODY>
</HTML>