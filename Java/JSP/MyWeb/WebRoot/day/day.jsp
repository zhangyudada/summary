<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page import="java.util.Date" %>
<HTML>
<BODY>
<%
Date date=new Date(); //��õ��������
String date_cn ="";
String dateStr = "";
switch(date.getDay()) //�жϵ��������ڼ�
{
case 0:date_cn ="��"; break;
case 1:date_cn ="һ"; break;
case 2:date_cn ="��"; break;
case 3:date_cn ="��"; break;
case 4:date_cn ="��"; break;
case 5:date_cn ="��"; break;
case 6:date_cn ="��"; break;
}
dateStr = (1900+date.getYear()) + "��" + (date.getMonth()+1) + "��" + date.getDate() + "��(����" + date_cn + ")";
%>
document.write("<%=dateStr%>");
</BODY>
</HTML>