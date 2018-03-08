<%@ page contentType="text/html;charset=GB2312" %>
<html>
<head><title>JSP脚本语法示例</title></head>
<body>
计算100以内所有数和的JSP脚本运行结果如下：
<br>
<% int i, sum=0;
for(i=1;i<=100;i=i+1)
{ sum=sum+i;
}
%>
从1到100所有数之和是：<%=sum %>
</body>
</html>