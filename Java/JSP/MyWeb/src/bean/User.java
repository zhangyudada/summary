//����һ��JavaBean�������û����û���������
//�ṩ��ȡ��Ա�������޸ĳ�Ա�����ķ���
package bean;
public class User {
	String username;
	String password;
	//�޲εĹ��췽��
	public User(){
		username=null;
		password=null;
	}
	
	public String getUsername(){
		return username;
	}
	
	public void setUsername(String usr){
		username=usr;
	}
	
	public String getPassword(){
		return password;
	}
	
	public void setPassword(String psd){
		password=psd;
	}
}
