<%@ page contentType="text/html;charset=GB2312" %>
<%@ page import="bean.Circle"%>
<HTML>
<BODY bgcolor=cyan>
<Font size=2>
<jsp:useBean id="bean0" class="bean.Circle" scope="page" />
<% // ����Բ�İ뾶��
bean0.setRadius(100);
%>
<P>Բ�İ뾶�ǣ�<%=bean0.getRadius()%>
</P>
<P>Բ���ܳ��ǣ�<%=bean0.circlLength()%>
</P>
Բ������ǣ�<%=bean0.circleArea()%>
</Font>
</BODY>
</HTML>