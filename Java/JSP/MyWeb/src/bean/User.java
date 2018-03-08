//这是一个JavaBean，存有用户的用户名及密码
//提供获取成员变量和修改成员变量的方法
package bean;
public class User {
	String username;
	String password;
	//无参的构造方法
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
