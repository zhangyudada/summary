import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
public class Sizeyunsuan extends JFrame implements ActionListener
{
	private Font f1,f2;
	private Color c1;
	private JLabel label_tishi1,label_tishi2;
	private JLabel label_choose;
	private JTextField text_choose;        //ѡ�����������
	private JLabel label_rest;
	private JTextField text_rest;          //ʣ������
	private JLabel label_num1,label_operator,label_num2;
	private JTextField text_result;
	private JButton button_confirm,button_next;
	private int r;                         //����������������
	private int num_choose;                //���ڼ�¼��Ҫ������Ŀ��
	private int num_rest;                  //���ڼ�¼ʣ������
	private int count=0;                   //ͳ�ƴ�Ե�����
	
	public Sizeyunsuan()                   //��ܵĹ��췽��
	{
		super("�������������");                //��ܱ���
		this.setSize(455,200);             //��ܴ�С����λ������
		this.setLayout(new GridLayout(6,1,10,5));
		                        //��ܲ��֣�6��1�У�
		                        //���ˮƽ���10���أ���ֱ���5����
		this.setLocationRelativeTo(null);  //��ܾ���
		this.setDefaultCloseOperation(EXIT_ON_CLOSE); //�رտ��
		f1=new Font("΢���ź�",Font.BOLD,13);  //����������
		f2=new Font("��Բ",Font.BOLD,14);
		c1=new Color(57,221,36);            //��������ɫ
		
		label_tishi1=new JLabel("       ˵����0��100�����Ӽ��˳�" +
				            "�������㣬����ΪС�����������뱣��");
		this.add(label_tishi1);             //��ܵ�1�У���ʾ�����ʾ��Ϣ
		label_tishi1.setFont(f1);           //���������ʽ
		label_tishi1.setForeground(c1);     //����������ɫ
		label_tishi2=new JLabel("С�������λ��");
		this.add(label_tishi2);             //��ܵ�2�У���ʾ�����ʾ��Ϣ
		label_tishi2.setFont(f1);           //���������ʽ
		label_tishi2.setForeground(c1);     //����������ɫ
		
		//ѡ������������
		JPanel panel1=new JPanel(new GridLayout(1,3,10,5));
		label_choose=new JLabel("�ף���Ҫ�������⣿",JLabel.CENTER);
		panel1.add(label_choose);
		label_choose.setFont(f2);
		text_choose=new JTextField("5");
		panel1.add(text_choose);
		button_confirm=new JButton("ȷ��");
		button_confirm.setFont(f2);
		button_confirm.setBackground(Color.cyan);
		button_confirm.setOpaque(true);        
		            //setOpaqueIture)������Ŀ�����������ɲ�͸����
		            //����������button_confirm�������õ���ɫ������ʾ������
		button_confirm.addActionListener(this);    
		            //Ϊ��ȷ�ϡ���ťע�ᶯ���¼�������
		panel1.add(button_confirm);
		num_choose=Integer.parseInt(text_choose.getText());
		
		//��ʾʣ�����������
		JPanel panel2=new JPanel(new GridLayout(1,3,10,5));
		label_rest=new JLabel("ʣ������",JLabel.CENTER);
		panel2.add(label_rest);
		label_rest.setFont(f2);
		text_rest=new JTextField();
		panel2.add(text_rest);
		panel2.add(new JLabel(""));
		num_rest=num_choose-1;
		text_rest.setText(""+num_rest);  //��ʾʣ������
		text_rest.setEditable(false);    //���ò��ɱ༭��ֻ������ʾ
		
		//���Ⲣ����𰸵����
		JPanel panel3=new JPanel(new GridLayout(1,5,10,5));
		label_num1=new JLabel(String.valueOf(
				            (int)(Math.random()*100)),
				              JLabel.CENTER);
	                                    //�������һ��0-100������������
		panel3.add(label_num1);
		char[]ch={'+','-','*','/'};     //�ַ������д���
									    //��+��-��*��/���ĸ������
		r=(int)(Math.random()*4);       //�������һ��0-4������    
		label_operator=new JLabel(String.valueOf(ch[r]),
				                  JLabel.CENTER);
		                        //���������+��-��*��/���ĸ������������
		label_operator.setFont(f2);   //������������壬���ڿ���
		panel3.add(label_operator);
		label_num2=new JLabel(String.valueOf(
				           (int)(Math.random()*100)+1),
				               JLabel.CENTER);
        						//�������һ��1-100������������
		panel3.add(label_num2);
		panel3.add(new JLabel("=",JLabel.CENTER));
		text_result=new JTextField();   //����𰸵��ı���
		panel3.add(text_result);
		
		//��һ�ⰴť���ύ��ť
		JPanel panel4=new JPanel(new GridLayout(1,5));
		panel4.add(new JLabel(""));
		panel4.add(new JLabel(""));
		button_next=new JButton("��һ��");
		button_next.setFont(f2);
		button_next.setBackground(Color.cyan);
		button_next.setOpaque(true); 
		button_next.addActionListener(this);    
		                 //Ϊ����һ�⡱��ťע�ᶯ���¼�������
		panel4.add(button_next);
		panel4.add(new JLabel(""));
		panel4.add(new JLabel(""));
		
		this.add(panel1);
		this.add(panel2);
		this.add(panel3);
		this.add(panel4);
		this.setVisible(true);  //���ÿ�ܿ���
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
	 
	//�ж��ַ����Ƿ�Ϊ�Ǹ�����
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
	
	//ʵ�ְ�ť�Ķ����¼��������ӿ�
	public void actionPerformed(ActionEvent ev)    
	{
        if(ev.getSource()==button_confirm) //�����ȷ�ϡ���ťʱ
        {
        	String str_choose=text_choose.getText();  
        	                            //���ѡ����������ַ���
        	
        	//ֻ������Ĵ������ǲ�����1000�ķǸ�����ʱ��
        	//��ִ����ز��裬���򵯳���ʾ�Ի���
        	if(isNonNagativeInteger(str_choose)
        		&&Integer.parseInt(str_choose)<=1000)
        	{
        	num_choose=Integer.parseInt(str_choose);
        	num_rest=num_choose-1;
    		text_rest.setText(""+num_rest); //��ʾʣ������
    		text_result.setText("");        //���������
    		count=0;                        //���������0
        	}
        	else
        		JOptionPane.showMessageDialog(this, "������������" +
        				             "�������Ϊ������1000����������");
        		
        }
        
        else if(ev.getSource()==button_next) //�������һ�⡱��ťʱ
		{
        	String str_result=text_result.getText();  
        	                          //��ô�������������ַ���
        	
        	//ֻ���������ִ��ʱ����ִ����ز��裬���򵯳���ʾ�Ի���
        	if(isNumber(str_result))             
        	{
        	double temple=Double.parseDouble(str_result);
            double num_result=Math.round(temple*100)/100.0; 
                                   //����������Ĵ𰸣�����С�������λ
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
					    		              "�治���ش���ȷ��");
				           text_result.setText("");  //��մ�����
				           count++;
					      }
				       else
				    	  {
				    	   JOptionPane.showMessageDialog(this,
				    			        "���ϧ���ش������ȷ��Ϊ��"
				    	                     +(num1+num2));
				    	                     //����С�������λ
				    	   text_result.setText("");//��մ�����
				    	  }  break;
				case 1:if(num_result==(num1-num2))
			              {
			               JOptionPane.showMessageDialog(this,
			            		              "�治���ش���ȷ��");
		                   text_result.setText("");      
		                   count++;
			              }
		               else
		    	          {
		    	           JOptionPane.showMessageDialog(this,
		    	        		        "���ϧ���ش������ȷ��Ϊ��"
		    	                              +(num1-num2));       
		    	           text_result.setText("");      
		    	           }  break;
				case 2:if(num_result==(num1*num2))
	                       {
	                        JOptionPane.showMessageDialog(this, 
	                        		           "�治���ش���ȷ��");
                            text_result.setText(""); 
                            count++;
	                       }
                       else
  	                       {
  	                        JOptionPane.showMessageDialog(this,
  	                        		    "���ϧ���ش������ȷ��Ϊ��"
  	                                         +(num1*num2));
  	                        text_result.setText("");    
  	                        }  break;
				case 3:if(num_result==
						  Math.round(((double)num1/
								  (double)num2)*100)/100.0)
	                        {
	                         JOptionPane.showMessageDialog(this,
	                        		            "�治���ش���ȷ��");
                             text_result.setText(""); 
                             count++;
	                        }
                       else
  	                        {
  	                         JOptionPane.showMessageDialog(this,
  	                        		     "���ϧ���ش������ȷ��Ϊ��"
  	                  +Math.round(((double)num1/
  	                		  (double)num2)*100)/100.0);
  	                         text_result.setText(""); 
  	                         }  break;
  	            }
				
				if(num_rest==0)  //�������֮�������һ��
  	            {
					JOptionPane.showMessageDialog(this,
				      "��һ���ش���"+num_choose+"���⣬"+"���д����"
  	                  +count+"����"+"���յ÷�Ϊ"
				      +Math.round(((double)count/
				    		  (double)num_choose)*100)
				      +"�֡�");
					text_result.setText("�������"); 
  	            }
				
				num_rest--;
				text_rest.setText(""+num_rest);
				
				num1=(int)(Math.random()*100); //�������һ��0-100������
				char[]ch={'+','-','*','/'};    //�ַ������д�����������
				                               //���ĸ������
				r=(int)(Math.random()*4);      //�������һ��0-4������    
				num2=(int)(Math.random()*100); //�������һ��0-100������
				label_num1.setText(String.valueOf(num1));
				label_operator.setText(String.valueOf(ch[r]));  
				            //���������+��-��*��/�����е�һ�������
				label_num2.setText(String.valueOf(num2));
			}
			else
				JOptionPane.showMessageDialog(this, 
						                "�����ѽ�����" +
						              "���������ô��������ٴ��⣡");
		}
        else               //�����������������ַ�����������
        	JOptionPane.showMessageDialog(this, "���������ִ𰸣�");
		}
	}
	
	public static void main(String arg[])
	{
		new Sizeyunsuan();    //�½���ܶ���
	}
}

