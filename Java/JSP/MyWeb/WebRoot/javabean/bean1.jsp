<%@ page contentType="text/html;charset=GB2312" %>
<%@ page import="bean.Circle"%>
<HTML>
<BODY bgcolor=cyan><Font size=2>
<jsp:useBean id="bean1" class="bean.Circle" scope="session" >
</jsp:useBean>
<P>Բ�İ뾶�ǣ�
<%=bean1.getRadius()%>
<A href="bean2.jsp"><BR>bean2.jsp </A>
</BODY>
</HTML>