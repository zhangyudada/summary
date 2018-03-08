<%@ page contentType="text/html;charset=GB2312" %>
<%@ page import="bean.Circle"%>
<HTML>
<BODY bgcolor=cyan>
<Font size=2>
<jsp:useBean id="bean0" class="bean.Circle" scope="page" />
<% // 设置圆的半径：
bean0.setRadius(100);
%>
<P>圆的半径是：<%=bean0.getRadius()%>
</P>
<P>圆的周长是：<%=bean0.circlLength()%>
</P>
圆的面积是：<%=bean0.circleArea()%>
</Font>
</BODY>
</HTML>