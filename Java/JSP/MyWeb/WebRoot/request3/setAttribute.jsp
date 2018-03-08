<%@ page contentType="text/html; charset=gb2312"%>
<html>
<body>
<%request.setAttribute("error","sorry, your username or password is wrong!");%>
<jsp:forward page="error1.jsp" />
</body>
</html>