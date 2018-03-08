import java.awt.*;
import java.awt.event.*;

import javax.swing.*;
import javax.swing.border.TitledBorder;

public class Matrixb extends JPanel implements ActionListener
{
	private Font f1;
	private Color c1,c2;
	private JTextField [][]b;
	private JButton button_jia;
	private JButton button_cheng;
	private JButton button_zhuanzhi;
	private JButton button_zhi;
	private JButton button_cleara;
	private JButton button_clearb;
	private Matrixa matrixa;
		
	//构造方法
	public Matrixb(Matrixa matrixa)
	{
		this.setBorder(new TitledBorder("矩阵b（作为矩阵b求转置的结果显示窗）"));
				         //设置面板带有含标题的边框线
		this.setLayout(new GridLayout(11,10,10,5));   
		                 //面板布局，10行10列，
		                 //组件水平间距10像素，垂直间距5像素
		this.matrixa=matrixa; //成员对象
		
		b = new JTextField[10][10];
		for(int i=0;i<10;i++)
			for(int j=0;j<10;j++)
			{
				b[i][j]=new JTextField();
				this.add(b[i][j]);
			}       //10*10的矩阵输入区
		
		f1=new Font("幼圆",Font.BOLD,14); //设置新字体
		c1=new Color(57,221,36);         //浅绿色
		c2=new Color(115,211,239);       //浅蓝色
			
		button_jia=new JButton("a+b");
		button_jia.setFont(f1);
		button_jia.setForeground(Color.white);
		                                 //按钮字体颜色为白色
		button_jia.setBackground(c1);
		button_jia.setOpaque(true);        
		               
		button_cheng=new JButton("a*b");
		button_cheng.setFont(f1);
		button_cheng.setForeground(Color.white);		                                
		button_cheng.setBackground(c2);
		button_cheng.setOpaque(true);        
		              
		button_zhuanzhi=new JButton("b的转置");
		button_zhuanzhi.setFont(f1);
		button_zhuanzhi.setForeground(Color.white);	                                
		button_zhuanzhi.setBackground(c1);
		button_zhuanzhi.setOpaque(true);        
		               
		button_zhi=new JButton("b的秩");
		button_zhi.setFont(f1);
		button_zhi.setForeground(Color.white);	                                 
		button_zhi.setBackground(c2);
		button_zhi.setOpaque(true); 
		
		button_cleara=new JButton("清空a");
		button_cleara.setFont(f1);
		button_cleara.setForeground(Color.white);	                                 
		button_cleara.setBackground(c1);
		button_cleara.setOpaque(true);
		
		button_clearb=new JButton("清空b");
		button_clearb.setFont(f1);
		button_clearb.setForeground(Color.white);	                                 
		button_clearb.setBackground(c2);
		button_clearb.setOpaque(true);
		
		button_jia.addActionListener(this);    
                      //为“a+b”按钮注册动作事件监听器
        button_cheng.addActionListener(this);  
        button_zhuanzhi.addActionListener(this);  
        button_zhi.addActionListener(this);  
        button_cleara.addActionListener(this);
        button_clearb.addActionListener(this);
		
		this.add(button_jia);
		this.add(new JLabel(""));
		this.add(button_cheng);
		this.add(new JLabel(""));
		this.add(button_zhuanzhi);
		this.add(new JLabel(""));
		this.add(button_zhi);
		this.add(new JLabel(""));
		this.add(button_cleara);
		this.add(button_clearb);
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
	 
	//实现按钮的动作事件监听器接口
	 public void actionPerformed(ActionEvent ev) 
	 {
		//如果点击按钮“a+b”
		 if(ev.getSource()==button_jia) 
		 {
			 int ma,na,mb,nb;
			 ma=na=mb=nb=0;     //ma、na是矩阵a的行、列数
			                    //mb、nb是矩阵b的行、列数
			 int i,j,count=0;
			 double x,y;
			 double z[][]=new double[10][10];
			 
			 //四个for语句实现分别求出矩阵a、b的行、列数
			 for(i=0;isNumber(matrixa.a[i][0].getText());i++)
				 ma++;   //以矩阵a第一列的数字个数作为矩阵a的行数
			 for(j=0;isNumber(matrixa.a[0][j].getText());j++)
				 na++;   //以矩阵a第一行的数字个数作为矩阵a的列数
			 for(i=0;isNumber(b[i][0].getText());i++)
				 mb++;   //以矩阵b第一列的数字个数作为矩阵b的行数
			 for(j=0;isNumber(b[0][j].getText());j++)
				 nb++;   //以矩阵b第一行的数字个数作为矩阵b的列数
			 
			 if((ma==0&&na==0)||(mb==0&&nb==0))
				 JOptionPane.showMessageDialog(null, "矩阵不能为空！");
			              //未输入数据就点击“a+b”按钮时，进行提示
			 else if((ma!=mb)||(na!=nb))
				 JOptionPane.showMessageDialog(null, "矩阵相加，" +
				 		         "必须保证相加两矩阵行数相等、列数也相等！");
                          //输入的矩阵行、列数不匹配时，进行提示
			 else
			 {
				 sometag:
				 for(i=0;i<ma;i++)
					 for(j=0;j<na;j++)
						 try
				 		 {
							 x=Double.parseDouble(
									 matrixa.a[i][j].getText());
							 y=Double.parseDouble(
									 b[i][j].getText());
							              //获得矩阵第i行第j列的数字
							 z[i][j]=x+y; //保存矩阵相加的结果
							 count++;     //记录矩阵中输入数字的文本区的总数
				 		 }
				         catch (NumberFormatException e)
				         {
				        	 JOptionPane.showMessageDialog(null, 
				        			 "输入的不是矩阵，请改正！");
				        	         //输入的必须为矩阵形式，
				        	         //即m行n列必须全有数据，否则报错
				        	 break sometag;  //跳出两层循环
				         }
				 
				//若输入的矩阵符合规范，则在矩阵a中显示相加结果
				 if(count==ma*na)  
				 {
					 for(i=0;i<10;i++)
						 for(j=0;j<10;j++)
							 matrixa.a[i][j].setText("");
					               //先将作为显示区的矩阵a的
					 			   //10*10个文本区清空，便于观察结果
					 
					 for(i=0;i<ma;i++)
						 for(j=0;j<na;j++)
							 matrixa.a[i][j].setText(""+(z[i][j]));
					               //显示相加结果
				 }
			 }
		 }
		 
		 //如果点击按钮“a*b”
		 if(ev.getSource()==button_cheng)
		 {
			 int ma,na,mb,nb;
			 ma=na=mb=nb=0;     //ma、na是矩阵a的行、列数
			                    //mb、nb是矩阵b的行、列数
			 int i,j,count=0;
			 double x[][]=new double[10][10];
			 double y[][]=new double[10][10];
			 double z[][]=new double[10][10];
			 
			 //四个for语句实现分别求出矩阵a、b的行、列数
			 for(i=0;isNumber(matrixa.a[i][0].getText());i++)
				 ma++;
			 for(j=0;isNumber(matrixa.a[0][j].getText());j++)
				 na++;
			 for(i=0;isNumber(b[i][0].getText());i++)
				 mb++;
			 for(j=0;isNumber(b[0][j].getText());j++)
				 nb++;
			 
			 if((ma==0&&na==0)||(mb==0&&nb==0))
				 JOptionPane.showMessageDialog(null, "矩阵不能为空！");
			              //未输入数据就点击“a*b”按钮时，进行提示
			 else if(na!=mb)
				 JOptionPane.showMessageDialog(null, "矩阵a*b，" +
				 		         "必须保证a的列数等于b的行数！");
                          //输入的矩阵不能相乘时，进行提示
			 else
			 {
				 sometag:
				 for(i=0;i<ma;i++)
					 for(j=0;j<na;j++)
						 try
				 		 {
							 x[i][j]=Double.parseDouble(
									 matrixa.a[i][j].getText());
							    //获得矩阵a中的数据
							 count++;
				 		 }
				         catch (NumberFormatException e)
				         {
				        	 JOptionPane.showMessageDialog(null,
				        			 "输入的a不是矩阵，请改正！");
				        	    //输入的必须为矩阵形式，
				        	    //即m行n列必须全有数据，否则报错
				        	 break sometag;
				         }
			 
				 sometag:
				 for(i=0;i<mb;i++)
					 for(j=0;j<nb;j++)
						 try
				 		 {
							 y[i][j]=Double.parseDouble(
									 b[i][j].getText());
							    //获得矩阵b中的数据
							 count++;
				 		 }
				         catch (NumberFormatException e)
				         {
				        	 JOptionPane.showMessageDialog(null,
				        			 "输入的b不是矩阵，请改正！");
				        	          //输入的必须为矩阵形式，
				        	          //即m行n列必须全有数据，否则报错
				        	 break sometag;   
				         }
				 
				 //若输入的矩阵符合规范，则在矩阵a中显示相加结果
				 if(count==ma*na+mb*nb)     
				 {
					 for(i=0;i<10;i++)
						 for(j=0;j<10;j++)
							 matrixa.a[i][j].setText("");
					            //先将作为显示区的矩阵a的
					            //10*10个文本区清空，便于观察结果
					 
					 //相乘后的矩阵行数与a矩阵相同，列数与b矩阵相同
					 for(i=0;i<ma;i++)     
						 for(j=0;j<nb;j++)
						 {
							 for(int k=0;k<na;k++)
							 z[i][j]+=x[i][k]*y[k][j];
							 matrixa.a[i][j].setText(""+(z[i][j]));
						 }
				 }
			 }
		 }
		 
		 //如果点击按钮“b的转置”
		 if(ev.getSource()==button_zhuanzhi)
		 {
			 int mb,nb;     //mb、nb是矩阵b的行、列数
			 mb=nb=0;                                        
			 int i,j,count=0;
			 double x[][]=new double[10][10];
			 
			//两个for语句实现分别求出矩阵b的行、列数
			 for(i=0;isNumber(b[i][0].getText());i++)
				 mb++;
			 for(j=0;isNumber(b[0][j].getText());j++)
				 nb++;
			 
			 if(mb==0&&nb==0)
				 JOptionPane.showMessageDialog(null,
						     "矩阵b不能为空！");
			              //未输入数据就点击“b的转置”按钮时，进行提示
			 else
			 {
				 sometag:
				 for(i=0;i<mb;i++)
					 for(j=0;j<nb;j++)
						 try
				 		 {
							 x[i][j]=Double.parseDouble(
									 b[i][j].getText());
							    //获得矩阵b中的数据
							 count++;
				 		 }
				         catch (NumberFormatException e)
				         {
				        	 JOptionPane.showMessageDialog(null, 
				        			   "输入的b不是矩阵，请改正！");
				        	    //输入的必须为矩阵形式，
				        	    //即m行n列必须全有数据，否则报错
				        	 break sometag;
				         }
				 
				 //若输入的矩阵符合规范，则在矩阵b中显示b的转置
				 if(count==mb*nb) 
				 {
					 for(i=0;i<10;i++)
						 for(j=0;j<10;j++)
							 b[i][j].setText("");
					            //先将作为显示区的矩阵b的
					            //10*10个文本区清空，便于观察结果
					 for(i=0;i<mb;i++)
						 for(j=0;j<nb;j++)
							 b[j][i].setText(""+(x[i][j])); 
				 }
			 }
		 }
		 
		 //如果点击按钮“b的秩”
		 if(ev.getSource()==button_zhi)
		 {
			 int mb,nb;     //mb、nb是矩阵b的行、列数
			 mb=nb=0;                                        
			 int i,j,count=0;
			 int rank=0;    //矩阵b的秩
			 double max;
			 double x[][]=new double[10][10];
			 
			//两个for语句实现分别求出矩阵b的行、列数
			 for(i=0;isNumber(b[i][0].getText());i++)
				 mb++;
			 for(j=0;isNumber(b[0][j].getText());j++)
				 nb++;
			 
			 if(mb==0&&nb==0)
				 JOptionPane.showMessageDialog(null,
						     "矩阵b不能为空！");
			              //未输入数据就点击“b的秩”按钮时，进行提示
			 else
			 {
				 sometag:
				 for(i=0;i<mb;i++)
					 for(j=0;j<nb;j++)
						 try
				 		 {
							 x[i][j]=Double.parseDouble(
									 b[i][j].getText());
							    //获得矩阵b中的数据
							 count++;
				 		 }
				         catch (NumberFormatException e)
				         {
				        	 JOptionPane.showMessageDialog(null, 
				        			   "输入的b不是矩阵，请改正！");
				        	    //输入的必须为矩阵形式，
				        	    //即m行n列必须全有数据，否则报错
				        	 break sometag;
				         }
				 
				 //若输入的矩阵符合规范，则用高斯-约当法求出矩阵b的秩
				 if(count==mb*nb)
				 {
					double temp;
					int m,zhu;
					for(i=0;i<mb;i++)
					{
						//选列主元（即第i列最大的元素）
						max=Math.abs(x[i][i]);
						zhu=i;
						for(m=i+1;m<mb;m++)
						{
							if(Math.abs(x[m][i])>max)
							{
								max=Math.abs(x[m][i]);
								zhu=m;  //记录主元所在行数
							}							
						}
						
						//如果主元为一个极小的数，则不用再消元
						if(Math.abs(max)<Math.pow(10,-10))
							continue;
						
						for(j=0;j<nb&&zhu!=i;j++)
						{
							temp=x[zhu][j];
							x[zhu][j]=x[i][j];
							x[i][j]=temp;
						}
						
						//高斯-约当消元法
						double w=x[i][i];
						for(j=0;j<nb;j++)
						{
							x[i][j]=x[i][j]/w;	
						}
						for(m=i+1;m<mb;m++)
						{
							temp=x[m][i];
							for(j=i;j<nb;j++)
							{
								x[m][j]-=x[i][j]*temp;  //消元
								if(x[m][j]<Math.pow(10,-5))
									x[m][j]=0;
							}
						}
					}
					
					
//					
//					 for(i=0;i<10;i++)
//						 for(j=0;j<10;j++)
//							 b[i][j].setText("");
//					            //先将作为显示区的矩阵b的
//					            //10*10个文本区清空，便于观察结果
//					 for(i=0;i<mb;i++)
//						 for(j=0;j<nb;j++)
//							 b[i][j].setText(""+(x[i][j]));
					
					
					for(i=0;i<mb;i++)
						if(x[i][i]==1)
							rank++;
					JOptionPane.showMessageDialog(null, 
		        			   "矩阵b的秩为："+rank);
				 }
			 }
		 }
		 
		 //如果点击按钮“清空a”
		 if(ev.getSource()==button_cleara)
		 {
			 for(int i=0;i<10;i++)
				 for(int j=0;j<10;j++)
					 matrixa.a[i][j].setText("");
			               //清空a矩阵
		 }
		 
		//如果点击按钮“清空a”
		 if(ev.getSource()==button_clearb)
		 {
			 for(int i=0;i<10;i++)
				 for(int j=0;j<10;j++)
					 b[i][j].setText("");
			               //清空b矩阵
		 }
		 
		 
			 
	 }
	

}
