<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*"%>
<%
	int count=1;
	int cookielen=0;
	Cookie temp=null; 
	Cookie[] cookies=request.getCookies(); 
 	String dated=new Date().toLocaleString(); //��ǰʱ��
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
ͨ����������<font color=blue></font>
�������������<font color=red>
<%=count%>
</font><br>
<font color=blue></font>
���ϴε����ʱ�䣺<font color=red>
<%=dated%>
</font><br>