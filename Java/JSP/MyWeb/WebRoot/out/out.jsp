<%@ page contentType="text/html;charset=GB2312" %>
<%@ page import="java.util.*" %>
<HTML>
<BODY>
<% int a=100;long b=300;boolean c=true;
out.println("<H2>���Ǳ���1�������С</HT2>");
out.println("<H3>���Ǳ���2�������С</HT3>");
out.print("<BR>");
out.println("a="+a); out.println("b="+b); out.println("c="+c);
%>
<Center>
<p><Font size=2 >����һ�����</Font>
<%out.print("<Font face= ����size=2 >");
out.println("<Table Border >");
out.println("<TR >");
out.println("<TH width=80>"+"��Ʒ��"+"</TH>");
out.println("<TH width=60>"+"����"+"</TH>");
out.println("<TH width=200>"+"�۸�(Ԫ)"+"</TH>");
out.println("</TR>");
out.println("<TR >");
out.println("<TD >"+"���"+"</TD>");
out.println("<TD >"+"ʳƷ"+"</TD>");
out.println("<TD >"+"2.50"+"</TD>");
out.println("</TR>");
out.println("<TR>");
out.println("<TD >"+"����"+"</TD>");
out.println("<TD >"+"�����Ʒ"+"</TD>");
out.println("<TD >"+"3.00"+"</TD>");
out.println("<TD width=100>"+" 5.50"+"</TD>");
out.println("</TR>");
out.println("</Table>");
out.print("</Font>") ;
%>
</Center>
</BODY>
</HTML>