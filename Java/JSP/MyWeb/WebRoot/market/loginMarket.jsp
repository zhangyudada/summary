<%@ page contentType="text/html;charset=GB2312" %>
<HTML>
<BODY bgcolor=cyan><FONT Size=2>
<% session.setAttribute("customer"," 顾客");
%>
<P>输入你的用户名进入学苑超市：
<FORM action="purchaseMarket.jsp" method=post name=form>
<INPUT type="text" name="boy">
<INPUT TYPE="submit" value="登录" name=submit>
</FORM>
<FONT>
</BODY>
</HTML>