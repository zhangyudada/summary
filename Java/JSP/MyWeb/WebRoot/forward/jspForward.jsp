<%@ page contentType="text/html;charset=GB2312" %>
<HTML>
<BODY>
<% double i=Math.random();
if(i>0.5)
{
%>
<jsp:forward page="variableDeclaration.jsp" ></jsp:forward>
<%
}
else
{
%>
<jsp:forward page="jspGrammar.jsp" ></jsp:forward>
<%
}
%>
<P>��仰������ı��ʽ��ֵ�������
<%=i%>
</BODY>
</HTML>