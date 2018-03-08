<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*"%>
<%
	int count=1;
	int cookielen=0;
	Cookie temp=null; 
	Cookie[] cookies=request.getCookies(); 
 	String dated=new Date().toLocaleString(); //当前时间
	if(cookies!=null) 	//第一次访问则跳过判断
		cookielen = cookies.length; 
	if(cookielen!=0){	//判断是否成功获得Cookie资料
 		for(int i=0;i<cookielen;i++){ 
 			temp=cookies[i]; //取得Cookie数组变量
			if(temp.getName().equals("accessCount")){ 
				count=Integer.parseInt(temp.getValue());//获取登录次数 
			}
 			if(temp.getName().equals("date")){
 				dated=temp.getValue();
 			}
 		}
  	}
 %>
 <%
	Cookie accessCount=new Cookie("accessCount", String.valueOf(count+1));
	Cookie date=new Cookie("date", new Date().toLocaleString());
	response.addCookie(accessCount);
	response.addCookie(date);
%>
通过这个浏览器<font color=blue></font>
您的浏览次数是<font color=red>
<%=count%>
</font><br>
<font color=blue></font>
您上次的浏览时间：<font color=red>
<%=dated%>
</font><br>