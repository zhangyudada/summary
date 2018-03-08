<%@ page contentType="text/html;charset=GB2312" %>
<HTML>
<BODY bgcolor=cyan><FONT Size=2>
<% String s=request.getParameter("boy");
session.setAttribute("name",s);
%>
<P>这里是学苑超市
<P>输入你想购买的商品以结帐：
<FORM action="checkOutMarket.jsp" method=post name=form>
<INPUT type="text" name="buy">
<INPUT TYPE="submit" value="确定" name=submit>
</FORM>
</FONT>
</BODY>
</HTML>