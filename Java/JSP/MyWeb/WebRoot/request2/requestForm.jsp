<%@ page contentType="text/html;charset=GB2312" %>
<html>
<body>
<%
String[] temp=request.getParameterValues("checkbox");
out.println("Your favorite sports are£º");
for(int i=0;i<temp.length;i++) {
out.println(temp[i]+" ");
}
%>
</body>
</html>