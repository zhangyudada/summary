import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class CountdownTimer extends JFrame 
             implements ActionListener,Runnable
{
	private Font f1,f2;
	private Color c1,c2,c3;
	private JLabel label_hour,label_minute,label_second;
	private JTextField text_hour,text_minute,text_second;
	private JButton button_start,button_reset;
	private Thread thread=new Thread(this);//线程对象
	private int hour,minute,second;        //设置的倒计时时间
	private int num_control=0;             //控制“开始”按钮
	                                       //与“暂停”按钮的相互转换
	
	public CountdownTimer()
	{
		super("倒计时器");                    //框架标题
		this.setSize(360,160);             //框架大小，单位是像素
		this.setLayout(new GridLayout(3,1,20,10));
		                                   //框架布局，3行1列，
		                                   //组件水平间距20像素，
		                                   //垂直间距10像素
		this.setLocationRelativeTo(null);  //框架居中
		this.setDefaultCloseOperation(EXIT_ON_CLOSE); //关闭框架
		f1=new Font("幼圆",Font.BOLD,20);              //设置新字体
		f2=new Font("幼圆",Font.BOLD,14);
		c1=new Color(244,65,175);          //洋红色
		c2=new Color(57,221,36);           //浅绿色
		c3=new Color(115,211,239);         //浅蓝色
		
		//显示“时、分、秒”三个汉字的面板
		JPanel panel1=new JPanel(new GridLayout(1,3,20,10));			                             
		label_hour=new JLabel("时",JLabel.CENTER);
        label_hour.setFont(f1);            //设置字体格式
		label_hour.setForeground(c1);      //设置字体颜色
		
		label_minute=new JLabel("分",JLabel.CENTER);
		label_minute.setFont(f1);         
		label_minute.setForeground(c1);    
		
		label_second=new JLabel("秒",JLabel.CENTER);		
		label_second.setFont(f1);           
		label_second.setForeground(c1);    
		
		panel1.add(label_hour);              
		panel1.add(label_minute);          
		panel1.add(label_second);   
		
		//设置时间并显示剩余时间的面板
	    JPanel panel2=new JPanel(new GridLayout(1,3,20,10));
	    text_hour=new JTextField("0");
	    text_hour.setFont(f1);             //设置字体格式
	    text_hour.setHorizontalAlignment(JTextField.CENTER);
		                                   //设置文本对齐方式，居中
	    
	    text_minute=new JTextField("0");
	    text_minute.setFont(f1); 
	    text_minute.setHorizontalAlignment(JTextField.CENTER);
	    
	    text_second=new JTextField("0");		
	    text_second.setFont(f1); 
	    text_second.setHorizontalAlignment(JTextField.CENTER);
                                             
		panel2.add(text_hour);              
		panel2.add(text_minute);          
		panel2.add(text_second);
		
		//按钮面板
	    JPanel panel3=new JPanel(new GridLayout(1,5));
						                     //面板布局，1行5列
		button_start=new JButton("开始");
		button_start.setFont(f2);
		button_start.setForeground(Color.white);
		                                     //按钮字体颜色为白色
		button_start.setBackground(c2);
		button_start.setOpaque(true);        
		               //setOpaqueIture)方法的目的是让组件变成不透明，
		               //这样在button_next上所设置的颜色才能显示出来。
		button_start.addActionListener(this);
		               //为“开始”按钮注册动作事件监听器
		
		button_reset=new JButton("复位");
		button_reset.setFont(f2);
		button_reset.setForeground(Color.white);
		                                     
		button_reset.setBackground(c3);
		button_reset.setOpaque(true);        
		button_reset.addActionListener(this);
		
		panel3.add(new JLabel(""));
		panel3.add(button_start);
		panel3.add(new JLabel(""));
		panel3.add(button_reset);
		panel3.add(new JLabel(""));
		
		this.add(panel1);
		this.add(panel2);
		this.add(panel3);
		
		this.setVisible(true);      //设置框架可视
	}
	
	//判断字符串是否为非负整数
	 public static boolean isNonNagativeInteger(String value) 
	 {
		 try 
		 {
			 int temp=Integer.parseInt(value);
			 if(temp>=0)
				 return true;
			 else
				 return false;
		  } 
		 catch (NumberFormatException e)
		 {
		     return false;
		 }
	  }
	
	//实现线程体
	public void run()
	{
		while(true)
			try
		    {   
				//时间显示设定
				if(second==-1)
				{
					second=59;
					minute--;
				}
				if(minute==-1)
				{
					minute=59;
					hour--;
				}
				
				//文本行显示剩余时间
				
				text_hour.setText(String.valueOf(hour));
				text_minute.setText(String.valueOf(minute));
				text_second.setText(String.valueOf(second));
				Thread.sleep(1000);         //线程睡眠1秒
				second--;
				
				//倒计时完成时，倒计时复位，有提示音并弹出对话框
				if(hour==0&&minute==0&&second==-1)
				{
					button_start.setText("开始");
					hour=0;
					minute=0;
					second=0;
					text_hour.setEditable(true);   //设置可编辑
			        text_minute.setEditable(true);
			        text_second.setEditable(true);
					text_hour.setText(""+hour);
					text_minute.setText(""+minute);
					text_second.setText(""+second);
					num_control=0;
					
					java.awt.Toolkit.getDefaultToolkit().beep(); 
					JOptionPane.showMessageDialog(null, 
							              "倒计时结束！");
					break;
				}
		    }
		
		    catch(InterruptedException ex)
		    {
		    	break;
		    }
	}
	
	//实现按钮的动作事件监听器接口
	public void actionPerformed(ActionEvent ev)    
	{
		//按下“复位”按钮时
		if(ev.getSource()==button_reset)
		{
			button_start.setText("开始");
			hour=0;
			minute=0;
			second=0;
			text_hour.setEditable(true);      //设置可编辑
	        text_minute.setEditable(true);
	        text_second.setEditable(true);
			text_hour.setText(""+hour);
			text_minute.setText(""+minute);
			text_second.setText(""+second);
			num_control=0;
			thread.interrupt();
		}
		
		//按下“开始”或“暂停”按钮时
		else if(ev.getSource()==button_start)
		{
			String str_hour,str_minute,str_second;
		    str_hour=text_hour.getText();
		    str_minute=text_minute.getText();
		    str_second=text_second.getText();
		
		    //只有输入非负整数时间时，才执行相关步骤，否则弹出提示对话框
		    if(isNonNagativeInteger(str_hour)
		       &&isNonNagativeInteger(str_minute)
		       &&isNonNagativeInteger(str_second))
		    {
			    hour=Integer.parseInt(str_hour);
			    minute=Integer.parseInt(str_minute);
			    second=Integer.parseInt(str_second);
			    
			    if(hour==0&&minute==0&&second==0)
			    	JOptionPane.showMessageDialog(this, 
			    			      "输入时间不能为0！");
			    
			    //输入的“时”必须为小于24的正整数，
			    //“分”与“秒”必须为小于60的正整数！
			    else if(hour<24&&minute<60&&second<60)
			    {
			    	if(num_control==0)
			    	{
			    		text_hour.setEditable(false); 
			    		            //设置不可编辑，只用于显示
				        text_minute.setEditable(false);
				        text_second.setEditable(false);
				        button_start.setText("暂停");
				        thread=new Thread(this);
				        thread.start();
				        num_control=1;
			    	}
			    	else if(num_control==1)
			    	{
			    		button_start.setText("开始");
			    		num_control=0;
			    		thread.interrupt();
			    	}
				    
			    }
			    else
				    JOptionPane.showMessageDialog(this, 
				    		         "输入的" +
				    		     "“时”必须为小于24的正整数，" +
				    		    "“分”与“秒”必须为小于60的正整数！");
			}
		
		    else
			    JOptionPane.showMessageDialog(this, 
			    		"请输入正整数时间！");
		}
	}
	
	public static void main(String arg[])
	{
		new CountdownTimer();   //新建框架对象
	}
}
