import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
public class Sizeyunsuan extends JFrame implements ActionListener
{
	private Font f1,f2;
	private Color c1;
	private JLabel label_tishi1,label_tishi2;
	private JLabel label_choose;
	private JTextField text_choose;        //选择做题的数量
	private JLabel label_rest;
	private JTextField text_rest;          //剩余题数
	private JLabel label_num1,label_operator,label_num2;
	private JTextField text_result;
	private JButton button_confirm,button_next;
	private int r;                         //用于随机产生运算符
	private int num_choose;                //用于记录想要做的题目数
	private int num_rest;                  //用于记录剩余题数
	private int count=0;                   //统计答对的题数
	
	public Sizeyunsuan()                   //框架的构造方法
	{
		super("四则运算出题器");                //框架标题
		this.setSize(455,200);             //框架大小，单位是像素
		this.setLayout(new GridLayout(6,1,10,5));
		                        //框架布局，6行1列，
		                        //组件水平间距10像素，垂直间距5像素
		this.setLocationRelativeTo(null);  //框架居中
		this.setDefaultCloseOperation(EXIT_ON_CLOSE); //关闭框架
		f1=new Font("微软雅黑",Font.BOLD,13);  //设置新字体
		f2=new Font("幼圆",Font.BOLD,14);
		c1=new Color(57,221,36);            //设置新颜色
		
		label_tishi1=new JLabel("       说明：0—100整数加减乘除" +
				            "四则运算，如结果为小数则四舍五入保留");
		this.add(label_tishi1);             //框架第1行，显示相关提示消息
		label_tishi1.setFont(f1);           //设置字体格式
		label_tishi1.setForeground(c1);     //设置字体颜色
		label_tishi2=new JLabel("小数点后两位。");
		this.add(label_tishi2);             //框架第2行，显示相关提示消息
		label_tishi2.setFont(f1);           //设置字体格式
		label_tishi2.setForeground(c1);     //设置字体颜色
		
		//选择出题数的面板
		JPanel panel1=new JPanel(new GridLayout(1,3,10,5));
		label_choose=new JLabel("亲，你要做几道题？",JLabel.CENTER);
		panel1.add(label_choose);
		label_choose.setFont(f2);
		text_choose=new JTextField("5");
		panel1.add(text_choose);
		button_confirm=new JButton("确认");
		button_confirm.setFont(f2);
		button_confirm.setBackground(Color.cyan);
		button_confirm.setOpaque(true);        
		            //setOpaqueIture)方法的目的是让组件变成不透明，
		            //这样我们在button_confirm上所设置的颜色才能显示出来。
		button_confirm.addActionListener(this);    
		            //为“确认”按钮注册动作事件监听器
		panel1.add(button_confirm);
		num_choose=Integer.parseInt(text_choose.getText());
		
		//显示剩余题数的面板
		JPanel panel2=new JPanel(new GridLayout(1,3,10,5));
		label_rest=new JLabel("剩余题数",JLabel.CENTER);
		panel2.add(label_rest);
		label_rest.setFont(f2);
		text_rest=new JTextField();
		panel2.add(text_rest);
		panel2.add(new JLabel(""));
		num_rest=num_choose-1;
		text_rest.setText(""+num_rest);  //显示剩余题数
		text_rest.setEditable(false);    //设置不可编辑，只用于显示
		
		//出题并输入答案的面板
		JPanel panel3=new JPanel(new GridLayout(1,5,10,5));
		label_num1=new JLabel(String.valueOf(
				            (int)(Math.random()*100)),
				              JLabel.CENTER);
	                                    //随机产生一个0-100的整数，居中
		panel3.add(label_num1);
		char[]ch={'+','-','*','/'};     //字符数组中存有
									    //“+、-、*、/”四个运算符
		r=(int)(Math.random()*4);       //随机产生一个0-4的整数    
		label_operator=new JLabel(String.valueOf(ch[r]),
				                  JLabel.CENTER);
		                        //随机产生“+、-、*、/”四个运算符，居中
		label_operator.setFont(f2);   //设置运算符字体，便于看清
		panel3.add(label_operator);
		label_num2=new JLabel(String.valueOf(
				           (int)(Math.random()*100)+1),
				               JLabel.CENTER);
        						//随机产生一个1-100的整数，居中
		panel3.add(label_num2);
		panel3.add(new JLabel("=",JLabel.CENTER));
		text_result=new JTextField();   //输入答案的文本行
		panel3.add(text_result);
		
		//下一题按钮及提交按钮
		JPanel panel4=new JPanel(new GridLayout(1,5));
		panel4.add(new JLabel(""));
		panel4.add(new JLabel(""));
		button_next=new JButton("下一题");
		button_next.setFont(f2);
		button_next.setBackground(Color.cyan);
		button_next.setOpaque(true); 
		button_next.addActionListener(this);    
		                 //为“下一题”按钮注册动作事件监听器
		panel4.add(button_next);
		panel4.add(new JLabel(""));
		panel4.add(new JLabel(""));
		
		this.add(panel1);
		this.add(panel2);
		this.add(panel3);
		this.add(panel4);
		this.setVisible(true);  //设置框架可视
	}
	
	//判断字符串是否为整数
	 public static boolean isInteger(String value) 
	 {
		 try 
		 {
			 Integer.parseInt(value);
		     return true;
		  } 
		 catch (NumberFormatException e)
		 {
		     return false;
		 }
	  }
	 
	//判断字符串是否为浮点数
	 public static boolean isDouble(String value) 
	 {
		 try 
		 {
			 Double.parseDouble(value);
		     if (value.contains("."))
		    	 return true;
		     else
		    	 return false;
		  } 
		 catch (NumberFormatException e) 
		 {
		     return false;
		 }
	  }
	
	//判断字符串是否为数字
	 public static boolean isNumber(String value) 
	 {
		 return isInteger(value) || isDouble(value);
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
	
	//实现按钮的动作事件监听器接口
	public void actionPerformed(ActionEvent ev)    
	{
        if(ev.getSource()==button_confirm) //点击“确认”按钮时
        {
        	String str_choose=text_choose.getText();  
        	                            //获得选择区输入的字符串
        	
        	//只有输入的答题数是不大于1000的非负整数时，
        	//才执行相关步骤，否则弹出提示对话框
        	if(isNonNagativeInteger(str_choose)
        		&&Integer.parseInt(str_choose)<=1000)
        	{
        	num_choose=Integer.parseInt(str_choose);
        	num_rest=num_choose-1;
    		text_rest.setText(""+num_rest); //显示剩余题数
    		text_result.setText("");        //答题区清空
    		count=0;                        //答对题数置0
        	}
        	else
        		JOptionPane.showMessageDialog(this, "请输入题数，" +
        				             "输入必须为不大于1000的正整数！");
        		
        }
        
        else if(ev.getSource()==button_next) //点击“下一题”按钮时
		{
        	String str_result=text_result.getText();  
        	                          //获得答案输入区输入的字符串
        	
        	//只有输入数字打答案时，才执行相关步骤，否则弹出提示对话框
        	if(isNumber(str_result))             
        	{
        	double temple=Double.parseDouble(str_result);
            double num_result=Math.round(temple*100)/100.0; 
                                   //答题者输入的答案，保留小数点后两位
            int num1,num2;
			if(num_rest>=0)
			{
				num1=Integer.parseInt(label_num1.getText());
				num2=Integer.parseInt(label_num2.getText());
				switch(r)
				{
				case 0:if(num_result==(num1+num2))
					      {
					       JOptionPane.showMessageDialog(this, 
					    		              "真不错，回答正确！");
				           text_result.setText("");  //清空答题区
				           count++;
					      }
				       else
				    	  {
				    	   JOptionPane.showMessageDialog(this,
				    			        "真可惜，回答错误！正确答案为："
				    	                     +(num1+num2));
				    	                     //保留小数点后两位
				    	   text_result.setText("");//清空答题区
				    	  }  break;
				case 1:if(num_result==(num1-num2))
			              {
			               JOptionPane.showMessageDialog(this,
			            		              "真不错，回答正确！");
		                   text_result.setText("");      
		                   count++;
			              }
		               else
		    	          {
		    	           JOptionPane.showMessageDialog(this,
		    	        		        "真可惜，回答错误！正确答案为："
		    	                              +(num1-num2));       
		    	           text_result.setText("");      
		    	           }  break;
				case 2:if(num_result==(num1*num2))
	                       {
	                        JOptionPane.showMessageDialog(this, 
	                        		           "真不错，回答正确！");
                            text_result.setText(""); 
                            count++;
	                       }
                       else
  	                       {
  	                        JOptionPane.showMessageDialog(this,
  	                        		    "真可惜，回答错误！正确答案为："
  	                                         +(num1*num2));
  	                        text_result.setText("");    
  	                        }  break;
				case 3:if(num_result==
						  Math.round(((double)num1/
								  (double)num2)*100)/100.0)
	                        {
	                         JOptionPane.showMessageDialog(this,
	                        		            "真不错，回答正确！");
                             text_result.setText(""); 
                             count++;
	                        }
                       else
  	                        {
  	                         JOptionPane.showMessageDialog(this,
  	                        		     "真可惜，回答错误！正确答案为："
  	                  +Math.round(((double)num1/
  	                		  (double)num2)*100)/100.0);
  	                         text_result.setText(""); 
  	                         }  break;
  	            }
				
				if(num_rest==0)  //如果所答之题是最后一题
  	            {
					JOptionPane.showMessageDialog(this,
				      "你一共回答了"+num_choose+"道题，"+"其中答对了"
  	                  +count+"道，"+"最终得分为"
				      +Math.round(((double)count/
				    		  (double)num_choose)*100)
				      +"分。");
					text_result.setText("答题结束"); 
  	            }
				
				num_rest--;
				text_rest.setText(""+num_rest);
				
				num1=(int)(Math.random()*100); //随机产生一个0-100的整数
				char[]ch={'+','-','*','/'};    //字符数组中存有四则运算
				                               //的四个运算符
				r=(int)(Math.random()*4);      //随机产生一个0-4的整数    
				num2=(int)(Math.random()*100); //随机产生一个0-100的整数
				label_num1.setText(String.valueOf(num1));
				label_operator.setText(String.valueOf(ch[r]));  
				            //随机产生“+、-、*、/”其中的一个运算符
				label_num2.setText(String.valueOf(num2));
			}
			else
				JOptionPane.showMessageDialog(this, 
						                "答题已结束，" +
						              "请重新设置答题数后再答题！");
		}
        else               //如果答案输入区输入的字符串不是数字
        	JOptionPane.showMessageDialog(this, "请输入数字答案！");
		}
	}
	
	public static void main(String arg[])
	{
		new Sizeyunsuan();    //新建框架对象
	}
}

