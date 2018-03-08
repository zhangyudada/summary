<%@ page contentType="text/html;charset=GB2312" %>
<%@ page import="bean.Circle"%>
<HTML>
<BODY bgcolor=cyan><Font size=1>
<jsp:useBean id="bean1" class="bean.Circle" scope="session" >
</jsp:useBean>
<P>圆的半径是：
<%=bean1.getRadius()%>
<%bean1.setRadius(4);%>
<P>修改后的圆的半径是：
<%=bean1.getRadius()%>
</BODY>
</HTML>