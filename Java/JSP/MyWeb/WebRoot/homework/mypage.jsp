<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*"%>
<html>

<!-- 使用application实现网站总访客计数功能 -->
<%
	String visitorCount=(String)application.getAttribute("visitorCount"); //获得指定属性值
 	if(visitorCount==null)
 		visitorCount="1";
 	else
		if(session.isNew())
			visitorCount=(Integer.parseInt(visitorCount)+1)+"";
	application.setAttribute("visitorCount",visitorCount);                 //设置指定属性值
	out.print("您好!您是第 "+visitorCount+" 位访问者。<br>");       
 %>

<!-- 使用Cookie实现访客计数和显示上次浏览时间的功能 -->
<%
	int count=1;
	int cookielen=0;
	Cookie temp=null; 
	Cookie[] cookies=request.getCookies(); 
 	String dated=new Date().toLocaleString(); //当前时间，年月日时分秒显示格式
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
通过这个浏览器    您的浏览次数是
<font color=red>
<%=count%>
</font><br>
您上次的浏览时间：
<font color=red>
<%=dated%>
</font><br>

<head>
	<title>张宇的个人网站</title>
	<!--使用层叠样式表（CSS）来定义 HTML 元素的布局和显示属性-->
	<!--课本之外标签-->
	<style type="text/css">
	h1 {color: DodgerBlue}	<!—标题h1字体颜色为DodgerBlue -->
	</style>
</head>

<body background="./image/1.jpg">
	<h1 align="center">欢迎访问我的个人网站</h1>
	<h3>个人资料</h3>
	<p>
	<!--创建北京邮电大学的超链接-->
	<!--如果把链接的 target 属性设置为 "_blank"，该链接会在新窗口中	打开-->
大家好，我是来自<a href="http://www.bupt.edu.cn/" target="_blank">北京邮电大学</a>电子工程学院的张宇，在北邮呆了两年多，不知不觉已经大三了。这两年多交了很多好朋友，也学了很多知识，希望在接下来的大学时光里能够再接再厉。
	</p>
	<!--锚URL-->
	你可以<a href="#login">登录</a>我的网站

	<h3>爱好</h3>
	<p>
我主要有两个爱好：听歌，看动漫。最喜欢的动漫是<strong>夏目友人帐</strong>，不知道有没有同好的朋友。下面列举了一些我爱听的歌曲和爱看的动漫。
	</p>
	<!--自定义列表-->
	<dl>
		<dt>歌曲</dt>
			<dd>月光—胡彦斌</dd>
			<dd>山水之间—许嵩</dd>
			<dd>七里香—周杰伦</dd>
			<dd>幻化成风—つじあやの</dd>
			<dd>......</dd>
	<pre>	
	这首歌是《幻化成风》
	背景尤克里里的声音很好听，我很喜欢
	</pre>
	<!--插入音频-->
	<embed src="kaze.mp3" width="600" height="100" autostart=0 loop=ture/>
	<br/>
	<br/>
		<dt>动漫</dt>
			<dd>夏目友人帐</dd>
			<dd>虫师</dd>
			<dd>秦时明月</dd>
			<dd>龙猫</dd>
			<dd>千与千寻</dd>
			<dd>......</dd>
	</dl>
	<pre>
	夏目友人帐照片墙
	</pre>
	<!--插入图片-->
	<img src="./image/2.jpg" alt="夏目1" width="350" height="200"/>
	<img src="./image/3.jpg" alt="夏目2" width="350" height="200"/>
	<img src="./image/4.jpg" alt="夏目3" width="350" height="200"/>

	<h3>联系我</h3>
	<p>如果想要交个朋友的话，请给我
	<!--邮件链接，点击打开UA，我的是微软的OUTLOOK-->
	<!--这是另一个 mailto 链接, 使用 %20 来替换单词之间的空格-->
	<a href="mailto:zhangyu1993@bupt.edu.cn?subject=Make%20friend">发邮件</a>。
	</p>
	
	<!--锚点-->
	<a id="login"><h3>登录</h3></a>
	<p>你可以选择登录我的网站，加入我的网站</p>
	<!--登录表单-->
	<form name="login" action="loginResponse.jsp" method="get">
	用户：
	<input type="text" name="user">
	<br/>
	密码：
	<input type="password" name="password">
	<br/>
	<input type="submit" name="submit" value="Login">
	<input type="submit" name="submit" value="Register">
	</form>
	<br/>
	
	<!-- 这里设置一个超链接，链接到我的书店界面，进行购书操作-->
	<h3>我的书店</h3>
	<!--如果把链接的 target 属性设置为 "_blank"，该链接会在新窗口中	打开-->
	<p>如有需要，可以到<a href="loginBook.jsp" target="_blank">我的书店</a>选购图书。
	</p>
	
</body>
</html>
