<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*"%>
<html>

<!-- ʹ��applicationʵ����վ�ܷÿͼ������� -->
<%
	String visitorCount=(String)application.getAttribute("visitorCount"); //���ָ������ֵ
 	if(visitorCount==null)
 		visitorCount="1";
 	else
		if(session.isNew())
			visitorCount=(Integer.parseInt(visitorCount)+1)+"";
	application.setAttribute("visitorCount",visitorCount);                 //����ָ������ֵ
	out.print("����!���ǵ� "+visitorCount+" λ�����ߡ�<br>");       
 %>

<!-- ʹ��Cookieʵ�ַÿͼ�������ʾ�ϴ����ʱ��Ĺ��� -->
<%
	int count=1;
	int cookielen=0;
	Cookie temp=null; 
	Cookie[] cookies=request.getCookies(); 
 	String dated=new Date().toLocaleString(); //��ǰʱ�䣬������ʱ������ʾ��ʽ
	if(cookies!=null) 	//��һ�η����������ж�
		cookielen = cookies.length; 
	if(cookielen!=0){	//�ж��Ƿ�ɹ����Cookie����
 		for(int i=0;i<cookielen;i++){ 
 			temp=cookies[i]; //ȡ��Cookie�������
			if(temp.getName().equals("accessCount")){ 
				count=Integer.parseInt(temp.getValue());//��ȡ��¼���� 
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
ͨ����������    �������������
<font color=red>
<%=count%>
</font><br>
���ϴε����ʱ�䣺
<font color=red>
<%=dated%>
</font><br>

<head>
	<title>����ĸ�����վ</title>
	<!--ʹ�ò����ʽ��CSS�������� HTML Ԫ�صĲ��ֺ���ʾ����-->
	<!--�α�֮���ǩ-->
	<style type="text/css">
	h1 {color: DodgerBlue}	<!������h1������ɫΪDodgerBlue -->
	</style>
</head>

<body background="./image/1.jpg">
	<h1 align="center">��ӭ�����ҵĸ�����վ</h1>
	<h3>��������</h3>
	<p>
	<!--���������ʵ��ѧ�ĳ�����-->
	<!--��������ӵ� target ��������Ϊ "_blank"�������ӻ����´�����	��-->
��Һã���������<a href="http://www.bupt.edu.cn/" target="_blank">�����ʵ��ѧ</a>���ӹ���ѧԺ������ڱ��ʴ�������࣬��֪�����Ѿ������ˡ�������ཻ�˺ܶ�����ѣ�Ҳѧ�˺ܶ�֪ʶ��ϣ���ڽ������Ĵ�ѧʱ�����ܹ��ٽ�������
	</p>
	<!--êURL-->
	�����<a href="#login">��¼</a>�ҵ���վ

	<h3>����</h3>
	<p>
����Ҫ���������ã����裬����������ϲ���Ķ�����<strong>��Ŀ������</strong>����֪����û��ͬ�õ����ѡ������о���һЩ�Ұ����ĸ����Ͱ����Ķ�����
	</p>
	<!--�Զ����б�-->
	<dl>
		<dt>����</dt>
			<dd>�¹⡪�����</dd>
			<dd>ɽˮ֮�䡪����</dd>
			<dd>�����㡪�ܽ���</dd>
			<dd>�û��ɷ硪�Ĥ������</dd>
			<dd>......</dd>
	<pre>	
	���׸��ǡ��û��ɷ硷
	�����ȿ�����������ܺ������Һ�ϲ��
	</pre>
	<!--������Ƶ-->
	<embed src="kaze.mp3" width="600" height="100" autostart=0 loop=ture/>
	<br/>
	<br/>
		<dt>����</dt>
			<dd>��Ŀ������</dd>
			<dd>��ʦ</dd>
			<dd>��ʱ����</dd>
			<dd>��è</dd>
			<dd>ǧ��ǧѰ</dd>
			<dd>......</dd>
	</dl>
	<pre>
	��Ŀ��������Ƭǽ
	</pre>
	<!--����ͼƬ-->
	<img src="./image/2.jpg" alt="��Ŀ1" width="350" height="200"/>
	<img src="./image/3.jpg" alt="��Ŀ2" width="350" height="200"/>
	<img src="./image/4.jpg" alt="��Ŀ3" width="350" height="200"/>

	<h3>��ϵ��</h3>
	<p>�����Ҫ�������ѵĻ��������
	<!--�ʼ����ӣ������UA���ҵ���΢���OUTLOOK-->
	<!--������һ�� mailto ����, ʹ�� %20 ���滻����֮��Ŀո�-->
	<a href="mailto:zhangyu1993@bupt.edu.cn?subject=Make%20friend">���ʼ�</a>��
	</p>
	
	<!--ê��-->
	<a id="login"><h3>��¼</h3></a>
	<p>�����ѡ���¼�ҵ���վ�������ҵ���վ</p>
	<!--��¼��-->
	<form name="login" action="loginResponse.jsp" method="get">
	�û���
	<input type="text" name="user">
	<br/>
	���룺
	<input type="password" name="password">
	<br/>
	<input type="submit" name="submit" value="Login">
	<input type="submit" name="submit" value="Register">
	</form>
	<br/>
	
	<!-- ��������һ�������ӣ����ӵ��ҵ������棬���й������-->
	<h3>�ҵ����</h3>
	<!--��������ӵ� target ��������Ϊ "_blank"�������ӻ����´�����	��-->
	<p>������Ҫ�����Ե�<a href="loginBook.jsp" target="_blank">�ҵ����</a>ѡ��ͼ�顣
	</p>
	
</body>
</html>
