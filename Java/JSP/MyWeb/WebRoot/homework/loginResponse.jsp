<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="bean.User"%>
<html>
<head>
	<title>��¼������</title>
</head>
<!--ʹ��JavaBean, ���Խ���bean���½���User�࣬��һ��JavaBean,��¼��¼�û���Ϣ-->
<jsp:useBean id="beanuser" class="bean.User" scope="session" >
</jsp:useBean>
<body>
<% 
	String usr=null;	//��¼���û�����ֵ
	String psd=null;	//��¼��������ֵ
	String sub=null;	//��¼������submit��ťֵ
	String beanusr=null;//User��(JavaBean)һ��ʵ��beanuser����Ӧһ���û������û���
	String beanpsd=null;//User��(JavaBean)һ��ʵ��beanuser����Ӧһ���û���������
	
	//ʹ��request�����ȡ��¼���е��û����������Լ�submit��ťֵ
	usr=request.getParameter("user");		//��ȡ��¼���û�����ֵ
	psd=request.getParameter("password");	//��ȡ��¼��������ֵ
	sub=request.getParameter("submit");		//��ȡ��¼������submit��ťֵ
	
	//���δ�����û��������룬��ʹ��<jsp:forward>����Ԫ����ת��������棬������ִ�е�ǰҳ��
	if(usr.equals("")||psd.equals("")){
		%>
		<jsp:forward page="loginError.jsp" ></jsp:forward>
		<%
	}
	
	//ʹ��JavaBean��getXXX()��������ȡ��Ա����ֵ
	beanusr=beanuser.getUsername();			//��ȡʵ��beanuser���û���
	beanpsd=beanuser.getPassword();			//��ȡʵ��beanuser������
	
	//����Login(��¼)��ť
	if(sub.equals("Login")){
		//�û��������붼��д��ȷ
		if(usr.equals(beanusr) && psd.equals(beanpsd)){
			out.print(usr+"����ӭ���ʱ�վ��"+"<br>"+"<br>");
		}
		//�û�����������д����ȷ��ʹ��response�����sendRedirect()����
		//����ض����ܣ��ض��򵽵�¼����
		else
			response.sendRedirect("mypage.jsp");
	}
	//�Լ�ע�Ṧ��
	//����Register(ע��)��ť
	//�õ�¼���е��û������������ע��
	if(sub.equals("Register")){
		//ʹ��JavaBean��setXXX()���������ó�Ա����ֵ
		beanuser.setUsername(usr);
		beanuser.setPassword(psd);
		out.print(usr+"����ϲ��ע��ɹ���"+"<br>"+"<br>");
	}	
%>
<!--ʹ��includeָ���ʶ��time.jsp�ļ����뵽��ǰҳ���У���ʾע����¼��ʱ��-->
<%@ include file="time.jsp" %>
</body>
</html>