<%@ page contentType="text/html;charset=GB2312" %>
<HTML>
<BODY bgcolor=cyan><FONT Size=2>
<% String s=request.getParameter("boy");
session.setAttribute("name",s);
%>
<P>������ѧԷ����
<P>�������빺�����Ʒ�Խ��ʣ�
<FORM action="checkOutMarket.jsp" method=post name=form>
<INPUT type="text" name="buy">
<INPUT TYPE="submit" value="ȷ��" name=submit>
</FORM>
</FONT>
</BODY>
</HTML>