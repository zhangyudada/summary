<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page import="java.util.Date" %>
<HTML>
<BODY>
<%
Date date=new Date(); //获得当天的日期
String date_cn ="";
String dateStr = "";
switch(date.getDay()) //判断当天是星期几
{
case 0:date_cn ="日"; break;
case 1:date_cn ="一"; break;
case 2:date_cn ="二"; break;
case 3:date_cn ="三"; break;
case 4:date_cn ="四"; break;
case 5:date_cn ="五"; break;
case 6:date_cn ="六"; break;
}
dateStr = (1900+date.getYear()) + "年" + (date.getMonth()+1) + "月" + date.getDate() + "日(星期" + date_cn + ")";
%>
document.write("<%=dateStr%>");
</BODY>
</HTML>