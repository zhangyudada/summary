<%@ page contentType="text/html;charset=GB2312" %>
<html>
<head><title>JSP�ű��﷨ʾ��</title></head>
<body>
����100�����������͵�JSP�ű����н�����£�
<br>
<% int i, sum=0;
for(i=1;i<=100;i=i+1)
{ sum=sum+i;
}
%>
��1��100������֮���ǣ�<%=sum %>
</body>
</html>