<%@ page language="java" contentType="text/html; charset=GBK" %>
<%! //处理字符串的方法：解决中文字符显示不出来的问题
	public String getString(String s){ 
		if(s==null){
			s="";
		} 
		try{
			byte b[]=s.getBytes("ISO-8859-1");
			s=new String(b);
		}
		catch(Exception e){
		}
		return s;
	}
%>

<html>
<head>
	<title>选购结果</title>
</head>

<body>
<%
	//使用session对象完成在多个页面中的数据转发功能
	String book=request.getParameter("books");
	session.setAttribute("goods",book);
%>

<%
	String guke=(String)session.getAttribute("customer");
	String xingming=(String)session.getAttribute("name");
	String shangping=(String)session.getAttribute("goods");
	guke=getString(guke);
	//字符转码，显示中文
	xingming=getString(xingming);
	shangping=getString(shangping);
%>
<%=guke%>
<%=xingming%>，您好！
<br>
您选购的书是：
<%=shangping%>
</body>
</html>