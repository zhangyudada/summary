<%@ page language="java" contentType="text/html; charset=GBK" %>
<html>
<head>
	<title>ѡ��ͼ��</title>
</head>

<body>
<%
	//ʹ��session��������ڶ��ҳ���е�����ת������
	String cus=request.getParameter("customername");
	//���δ�����û�������ʹ��<jsp:forward>����Ԫ����ת��������棬������ִ�е�ǰҳ��
	if(cus.equals("")){
		%>
		<jsp:forward page="bookError.jsp" ></jsp:forward>
		<%
	}	
	session.setAttribute("name",cus);
%>
��ѡ����Ҫ�����
<form name="buy" action="checkOutBook.jsp" method="post">
<!-- ѡ���б�ѡ����Ҫ�����ͼ�飬Ĭ��ѡ�С���Ϣ����Ӧ�û����� -->
<select name="books">
	<option value="ͨ��ԭ��">ͨ��ԭ��</option>
	<option value="���ݿ�">���ݿ�</option>
	<option value="��Ϣ����Ӧ�û���" selected="selected">��Ϣ����Ӧ�û���</option>
	<option value="�ź���ϵͳ">�ź���ϵͳ</option>
</select>
<input type="submit" name="submit" value="ȷ��">
</form>
</body>
</html>