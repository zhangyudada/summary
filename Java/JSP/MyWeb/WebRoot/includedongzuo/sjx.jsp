<%@ page contentType="text/html;charset=GB2312" %>
<HTML>
<BODY>
<%
out.print("<pre>");
int i=7,j,k;
for(j=1;j<i;j++)
{
for(k=0; k<j; k++)
out.print("*");
%>
<p></p>
<%
}
out.print("</pre>");
%>
</BODY>
</HTML>