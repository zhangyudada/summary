<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="bean.User"%>
<html>
<head>
	<title>登录表单处理</title>
</head>
<!--使用JavaBean, 在自建的bean包下建有User类，是一个JavaBean,记录登录用户信息-->
<jsp:useBean id="beanuser" class="bean.User" scope="session" >
</jsp:useBean>
<body>
<% 
	String usr=null;	//登录表单用户名栏值
	String psd=null;	//登录表单密码栏值
	String sub=null;	//登录表单两个submit按钮值
	String beanusr=null;//User类(JavaBean)一个实例beanuser（对应一个用户）的用户名
	String beanpsd=null;//User类(JavaBean)一个实例beanuser（对应一个用户）的密码
	
	//使用request对象获取登录表单中的用户名、密码以及submit按钮值
	usr=request.getParameter("user");		//获取登录表单用户名栏值
	psd=request.getParameter("password");	//获取登录表单密码栏值
	sub=request.getParameter("submit");		//获取登录表单两个submit按钮值
	
	//如果未输入用户名或密码，就使用<jsp:forward>动作元素跳转到出错界面，并不再执行当前页面
	if(usr.equals("")||psd.equals("")){
		%>
		<jsp:forward page="loginError.jsp" ></jsp:forward>
		<%
	}
	
	//使用JavaBean的getXXX()方法，获取成员变量值
	beanusr=beanuser.getUsername();			//获取实例beanuser的用户名
	beanpsd=beanuser.getPassword();			//获取实例beanuser的密码
	
	//按下Login(登录)按钮
	if(sub.equals("Login")){
		//用户名与密码都填写正确
		if(usr.equals(beanusr) && psd.equals(beanpsd)){
			out.print(usr+"，欢迎访问本站！"+"<br>"+"<br>");
		}
		//用户名或密码填写不正确，使用response对象的sendRedirect()方法
		//完成重定向功能，重定向到登录界面
		else
			response.sendRedirect("mypage.jsp");
	}
	//自加注册功能
	//按下Register(注册)按钮
	//用登录表单中的用户名与密码进行注册
	if(sub.equals("Register")){
		//使用JavaBean的setXXX()方法，设置成员变量值
		beanuser.setUsername(usr);
		beanuser.setPassword(psd);
		out.print(usr+"，恭喜你注册成功！"+"<br>"+"<br>");
	}	
%>
<!--使用include指令标识将time.jsp文件插入到当前页面中，显示注册或登录的时间-->
<%@ include file="time.jsp" %>
</body>
</html>