<%@ page language="java" contentType="text/html; charset=GBK" %>
<%! //�����ַ����ķ�������������ַ���ʾ������������
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
	<title>ѡ�����</title>
</head>

<body>
<%
	//ʹ��session��������ڶ��ҳ���е�����ת������
	String book=request.getParameter("books");
	session.setAttribute("goods",book);
%>

<%
	String guke=(String)session.getAttribute("customer");
	String xingming=(String)session.getAttribute("name");
	String shangping=(String)session.getAttribute("goods");
	guke=getString(guke);
	//�ַ�ת�룬��ʾ����
	xingming=getString(xingming);
	shangping=getString(shangping);
%>
<%=guke%>
<%=xingming%>�����ã�
<br>
��ѡ�������ǣ�
<%=shangping%>
</body>
</html>