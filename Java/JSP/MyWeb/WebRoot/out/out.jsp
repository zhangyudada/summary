<%@ page contentType="text/html;charset=GB2312" %>
<%@ page import="java.util.*" %>
<HTML>
<BODY>
<% int a=100;long b=300;boolean c=true;
out.println("<H2>这是标题1的字体大小</HT2>");
out.println("<H3>这是标题2的字体大小</HT3>");
out.print("<BR>");
out.println("a="+a); out.println("b="+b); out.println("c="+c);
%>
<Center>
<p><Font size=2 >这是一个表格</Font>
<%out.print("<Font face= 隶书size=2 >");
out.println("<Table Border >");
out.println("<TR >");
out.println("<TH width=80>"+"商品名"+"</TH>");
out.println("<TH width=60>"+"种类"+"</TH>");
out.println("<TH width=200>"+"价格(元)"+"</TH>");
out.println("</TR>");
out.println("<TR >");
out.println("<TD >"+"面包"+"</TD>");
out.println("<TD >"+"食品"+"</TD>");
out.println("<TD >"+"2.50"+"</TD>");
out.println("</TR>");
out.println("<TR>");
out.println("<TD >"+"肥皂"+"</TD>");
out.println("<TD >"+"清洁用品"+"</TD>");
out.println("<TD >"+"3.00"+"</TD>");
out.println("<TD width=100>"+" 5.50"+"</TD>");
out.println("</TR>");
out.println("</Table>");
out.print("</Font>") ;
%>
</Center>
</BODY>
</HTML>