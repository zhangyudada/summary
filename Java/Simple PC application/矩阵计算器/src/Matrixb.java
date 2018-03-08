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
		
	//���췽��
	public Matrixb(Matrixa matrixa)
	{
		this.setBorder(new TitledBorder("����b����Ϊ����b��ת�õĽ����ʾ����"));
				         //���������к�����ı߿���
		this.setLayout(new GridLayout(11,10,10,5));   
		                 //��岼�֣�10��10�У�
		                 //���ˮƽ���10���أ���ֱ���5����
		this.matrixa=matrixa; //��Ա����
		
		b = new JTextField[10][10];
		for(int i=0;i<10;i++)
			for(int j=0;j<10;j++)
			{
				b[i][j]=new JTextField();
				this.add(b[i][j]);
			}       //10*10�ľ���������
		
		f1=new Font("��Բ",Font.BOLD,14); //����������
		c1=new Color(57,221,36);         //ǳ��ɫ
		c2=new Color(115,211,239);       //ǳ��ɫ
			
		button_jia=new JButton("a+b");
		button_jia.setFont(f1);
		button_jia.setForeground(Color.white);
		                                 //��ť������ɫΪ��ɫ
		button_jia.setBackground(c1);
		button_jia.setOpaque(true);        
		               
		button_cheng=new JButton("a*b");
		button_cheng.setFont(f1);
		button_cheng.setForeground(Color.white);		                                
		button_cheng.setBackground(c2);
		button_cheng.setOpaque(true);        
		              
		button_zhuanzhi=new JButton("b��ת��");
		button_zhuanzhi.setFont(f1);
		button_zhuanzhi.setForeground(Color.white);	                                
		button_zhuanzhi.setBackground(c1);
		button_zhuanzhi.setOpaque(true);        
		               
		button_zhi=new JButton("b����");
		button_zhi.setFont(f1);
		button_zhi.setForeground(Color.white);	                                 
		button_zhi.setBackground(c2);
		button_zhi.setOpaque(true); 
		
		button_cleara=new JButton("���a");
		button_cleara.setFont(f1);
		button_cleara.setForeground(Color.white);	                                 
		button_cleara.setBackground(c1);
		button_cleara.setOpaque(true);
		
		button_clearb=new JButton("���b");
		button_clearb.setFont(f1);
		button_clearb.setForeground(Color.white);	                                 
		button_clearb.setBackground(c2);
		button_clearb.setOpaque(true);
		
		button_jia.addActionListener(this);    
                      //Ϊ��a+b����ťע�ᶯ���¼�������
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
	
	//�ж��ַ����Ƿ�Ϊ����
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
	 
	//�ж��ַ����Ƿ�Ϊ������
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
	
	//�ж��ַ����Ƿ�Ϊ����
	 public static boolean isNumber(String value) 
	 {
		 return isInteger(value) || isDouble(value);
	 }
	 
	//ʵ�ְ�ť�Ķ����¼��������ӿ�
	 public void actionPerformed(ActionEvent ev) 
	 {
		//��������ť��a+b��
		 if(ev.getSource()==button_jia) 
		 {
			 int ma,na,mb,nb;
			 ma=na=mb=nb=0;     //ma��na�Ǿ���a���С�����
			                    //mb��nb�Ǿ���b���С�����
			 int i,j,count=0;
			 double x,y;
			 double z[][]=new double[10][10];
			 
			 //�ĸ�for���ʵ�ֱַ��������a��b���С�����
			 for(i=0;isNumber(matrixa.a[i][0].getText());i++)
				 ma++;   //�Ծ���a��һ�е����ָ�����Ϊ����a������
			 for(j=0;isNumber(matrixa.a[0][j].getText());j++)
				 na++;   //�Ծ���a��һ�е����ָ�����Ϊ����a������
			 for(i=0;isNumber(b[i][0].getText());i++)
				 mb++;   //�Ծ���b��һ�е����ָ�����Ϊ����b������
			 for(j=0;isNumber(b[0][j].getText());j++)
				 nb++;   //�Ծ���b��һ�е����ָ�����Ϊ����b������
			 
			 if((ma==0&&na==0)||(mb==0&&nb==0))
				 JOptionPane.showMessageDialog(null, "������Ϊ�գ�");
			              //δ�������ݾ͵����a+b����ťʱ��������ʾ
			 else if((ma!=mb)||(na!=nb))
				 JOptionPane.showMessageDialog(null, "������ӣ�" +
				 		         "���뱣֤���������������ȡ�����Ҳ��ȣ�");
                          //����ľ����С�������ƥ��ʱ��������ʾ
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
							              //��þ����i�е�j�е�����
							 z[i][j]=x+y; //���������ӵĽ��
							 count++;     //��¼�������������ֵ��ı���������
				 		 }
				         catch (NumberFormatException e)
				         {
				        	 JOptionPane.showMessageDialog(null, 
				        			 "����Ĳ��Ǿ����������");
				        	         //����ı���Ϊ������ʽ��
				        	         //��m��n�б���ȫ�����ݣ����򱨴�
				        	 break sometag;  //��������ѭ��
				         }
				 
				//������ľ�����Ϲ淶�����ھ���a����ʾ��ӽ��
				 if(count==ma*na)  
				 {
					 for(i=0;i<10;i++)
						 for(j=0;j<10;j++)
							 matrixa.a[i][j].setText("");
					               //�Ƚ���Ϊ��ʾ���ľ���a��
					 			   //10*10���ı�����գ����ڹ۲���
					 
					 for(i=0;i<ma;i++)
						 for(j=0;j<na;j++)
							 matrixa.a[i][j].setText(""+(z[i][j]));
					               //��ʾ��ӽ��
				 }
			 }
		 }
		 
		 //��������ť��a*b��
		 if(ev.getSource()==button_cheng)
		 {
			 int ma,na,mb,nb;
			 ma=na=mb=nb=0;     //ma��na�Ǿ���a���С�����
			                    //mb��nb�Ǿ���b���С�����
			 int i,j,count=0;
			 double x[][]=new double[10][10];
			 double y[][]=new double[10][10];
			 double z[][]=new double[10][10];
			 
			 //�ĸ�for���ʵ�ֱַ��������a��b���С�����
			 for(i=0;isNumber(matrixa.a[i][0].getText());i++)
				 ma++;
			 for(j=0;isNumber(matrixa.a[0][j].getText());j++)
				 na++;
			 for(i=0;isNumber(b[i][0].getText());i++)
				 mb++;
			 for(j=0;isNumber(b[0][j].getText());j++)
				 nb++;
			 
			 if((ma==0&&na==0)||(mb==0&&nb==0))
				 JOptionPane.showMessageDialog(null, "������Ϊ�գ�");
			              //δ�������ݾ͵����a*b����ťʱ��������ʾ
			 else if(na!=mb)
				 JOptionPane.showMessageDialog(null, "����a*b��" +
				 		         "���뱣֤a����������b��������");
                          //����ľ��������ʱ��������ʾ
			 else
			 {
				 sometag:
				 for(i=0;i<ma;i++)
					 for(j=0;j<na;j++)
						 try
				 		 {
							 x[i][j]=Double.parseDouble(
									 matrixa.a[i][j].getText());
							    //��þ���a�е�����
							 count++;
				 		 }
				         catch (NumberFormatException e)
				         {
				        	 JOptionPane.showMessageDialog(null,
				        			 "�����a���Ǿ����������");
				        	    //����ı���Ϊ������ʽ��
				        	    //��m��n�б���ȫ�����ݣ����򱨴�
				        	 break sometag;
				         }
			 
				 sometag:
				 for(i=0;i<mb;i++)
					 for(j=0;j<nb;j++)
						 try
				 		 {
							 y[i][j]=Double.parseDouble(
									 b[i][j].getText());
							    //��þ���b�е�����
							 count++;
				 		 }
				         catch (NumberFormatException e)
				         {
				        	 JOptionPane.showMessageDialog(null,
				        			 "�����b���Ǿ����������");
				        	          //����ı���Ϊ������ʽ��
				        	          //��m��n�б���ȫ�����ݣ����򱨴�
				        	 break sometag;   
				         }
				 
				 //������ľ�����Ϲ淶�����ھ���a����ʾ��ӽ��
				 if(count==ma*na+mb*nb)     
				 {
					 for(i=0;i<10;i++)
						 for(j=0;j<10;j++)
							 matrixa.a[i][j].setText("");
					            //�Ƚ���Ϊ��ʾ���ľ���a��
					            //10*10���ı�����գ����ڹ۲���
					 
					 //��˺�ľ���������a������ͬ��������b������ͬ
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
		 
		 //��������ť��b��ת�á�
		 if(ev.getSource()==button_zhuanzhi)
		 {
			 int mb,nb;     //mb��nb�Ǿ���b���С�����
			 mb=nb=0;                                        
			 int i,j,count=0;
			 double x[][]=new double[10][10];
			 
			//����for���ʵ�ֱַ��������b���С�����
			 for(i=0;isNumber(b[i][0].getText());i++)
				 mb++;
			 for(j=0;isNumber(b[0][j].getText());j++)
				 nb++;
			 
			 if(mb==0&&nb==0)
				 JOptionPane.showMessageDialog(null,
						     "����b����Ϊ�գ�");
			              //δ�������ݾ͵����b��ת�á���ťʱ��������ʾ
			 else
			 {
				 sometag:
				 for(i=0;i<mb;i++)
					 for(j=0;j<nb;j++)
						 try
				 		 {
							 x[i][j]=Double.parseDouble(
									 b[i][j].getText());
							    //��þ���b�е�����
							 count++;
				 		 }
				         catch (NumberFormatException e)
				         {
				        	 JOptionPane.showMessageDialog(null, 
				        			   "�����b���Ǿ����������");
				        	    //����ı���Ϊ������ʽ��
				        	    //��m��n�б���ȫ�����ݣ����򱨴�
				        	 break sometag;
				         }
				 
				 //������ľ�����Ϲ淶�����ھ���b����ʾb��ת��
				 if(count==mb*nb) 
				 {
					 for(i=0;i<10;i++)
						 for(j=0;j<10;j++)
							 b[i][j].setText("");
					            //�Ƚ���Ϊ��ʾ���ľ���b��
					            //10*10���ı�����գ����ڹ۲���
					 for(i=0;i<mb;i++)
						 for(j=0;j<nb;j++)
							 b[j][i].setText(""+(x[i][j])); 
				 }
			 }
		 }
		 
		 //��������ť��b���ȡ�
		 if(ev.getSource()==button_zhi)
		 {
			 int mb,nb;     //mb��nb�Ǿ���b���С�����
			 mb=nb=0;                                        
			 int i,j,count=0;
			 int rank=0;    //����b����
			 double max;
			 double x[][]=new double[10][10];
			 
			//����for���ʵ�ֱַ��������b���С�����
			 for(i=0;isNumber(b[i][0].getText());i++)
				 mb++;
			 for(j=0;isNumber(b[0][j].getText());j++)
				 nb++;
			 
			 if(mb==0&&nb==0)
				 JOptionPane.showMessageDialog(null,
						     "����b����Ϊ�գ�");
			              //δ�������ݾ͵����b���ȡ���ťʱ��������ʾ
			 else
			 {
				 sometag:
				 for(i=0;i<mb;i++)
					 for(j=0;j<nb;j++)
						 try
				 		 {
							 x[i][j]=Double.parseDouble(
									 b[i][j].getText());
							    //��þ���b�е�����
							 count++;
				 		 }
				         catch (NumberFormatException e)
				         {
				        	 JOptionPane.showMessageDialog(null, 
				        			   "�����b���Ǿ����������");
				        	    //����ı���Ϊ������ʽ��
				        	    //��m��n�б���ȫ�����ݣ����򱨴�
				        	 break sometag;
				         }
				 
				 //������ľ�����Ϲ淶�����ø�˹-Լ�����������b����
				 if(count==mb*nb)
				 {
					double temp;
					int m,zhu;
					for(i=0;i<mb;i++)
					{
						//ѡ����Ԫ������i������Ԫ�أ�
						max=Math.abs(x[i][i]);
						zhu=i;
						for(m=i+1;m<mb;m++)
						{
							if(Math.abs(x[m][i])>max)
							{
								max=Math.abs(x[m][i]);
								zhu=m;  //��¼��Ԫ��������
							}							
						}
						
						//�����ԪΪһ����С��������������Ԫ
						if(Math.abs(max)<Math.pow(10,-10))
							continue;
						
						for(j=0;j<nb&&zhu!=i;j++)
						{
							temp=x[zhu][j];
							x[zhu][j]=x[i][j];
							x[i][j]=temp;
						}
						
						//��˹-Լ����Ԫ��
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
								x[m][j]-=x[i][j]*temp;  //��Ԫ
								if(x[m][j]<Math.pow(10,-5))
									x[m][j]=0;
							}
						}
					}
					
					
//					
//					 for(i=0;i<10;i++)
//						 for(j=0;j<10;j++)
//							 b[i][j].setText("");
//					            //�Ƚ���Ϊ��ʾ���ľ���b��
//					            //10*10���ı�����գ����ڹ۲���
//					 for(i=0;i<mb;i++)
//						 for(j=0;j<nb;j++)
//							 b[i][j].setText(""+(x[i][j]));
					
					
					for(i=0;i<mb;i++)
						if(x[i][i]==1)
							rank++;
					JOptionPane.showMessageDialog(null, 
		        			   "����b����Ϊ��"+rank);
				 }
			 }
		 }
		 
		 //��������ť�����a��
		 if(ev.getSource()==button_cleara)
		 {
			 for(int i=0;i<10;i++)
				 for(int j=0;j<10;j++)
					 matrixa.a[i][j].setText("");
			               //���a����
		 }
		 
		//��������ť�����a��
		 if(ev.getSource()==button_clearb)
		 {
			 for(int i=0;i<10;i++)
				 for(int j=0;j<10;j++)
					 b[i][j].setText("");
			               //���b����
		 }
		 
		 
			 
	 }
	

}
