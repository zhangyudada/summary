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
	private Thread thread=new Thread(this);//�̶߳���
	private int hour,minute,second;        //���õĵ���ʱʱ��
	private int num_control=0;             //���ơ���ʼ����ť
	                                       //�롰��ͣ����ť���໥ת��
	
	public CountdownTimer()
	{
		super("����ʱ��");                    //��ܱ���
		this.setSize(360,160);             //��ܴ�С����λ������
		this.setLayout(new GridLayout(3,1,20,10));
		                                   //��ܲ��֣�3��1�У�
		                                   //���ˮƽ���20���أ�
		                                   //��ֱ���10����
		this.setLocationRelativeTo(null);  //��ܾ���
		this.setDefaultCloseOperation(EXIT_ON_CLOSE); //�رտ��
		f1=new Font("��Բ",Font.BOLD,20);              //����������
		f2=new Font("��Բ",Font.BOLD,14);
		c1=new Color(244,65,175);          //���ɫ
		c2=new Color(57,221,36);           //ǳ��ɫ
		c3=new Color(115,211,239);         //ǳ��ɫ
		
		//��ʾ��ʱ���֡��롱�������ֵ����
		JPanel panel1=new JPanel(new GridLayout(1,3,20,10));			                             
		label_hour=new JLabel("ʱ",JLabel.CENTER);
        label_hour.setFont(f1);            //���������ʽ
		label_hour.setForeground(c1);      //����������ɫ
		
		label_minute=new JLabel("��",JLabel.CENTER);
		label_minute.setFont(f1);         
		label_minute.setForeground(c1);    
		
		label_second=new JLabel("��",JLabel.CENTER);		
		label_second.setFont(f1);           
		label_second.setForeground(c1);    
		
		panel1.add(label_hour);              
		panel1.add(label_minute);          
		panel1.add(label_second);   
		
		//����ʱ�䲢��ʾʣ��ʱ������
	    JPanel panel2=new JPanel(new GridLayout(1,3,20,10));
	    text_hour=new JTextField("0");
	    text_hour.setFont(f1);             //���������ʽ
	    text_hour.setHorizontalAlignment(JTextField.CENTER);
		                                   //�����ı����뷽ʽ������
	    
	    text_minute=new JTextField("0");
	    text_minute.setFont(f1); 
	    text_minute.setHorizontalAlignment(JTextField.CENTER);
	    
	    text_second=new JTextField("0");		
	    text_second.setFont(f1); 
	    text_second.setHorizontalAlignment(JTextField.CENTER);
                                             
		panel2.add(text_hour);              
		panel2.add(text_minute);          
		panel2.add(text_second);
		
		//��ť���
	    JPanel panel3=new JPanel(new GridLayout(1,5));
						                     //��岼�֣�1��5��
		button_start=new JButton("��ʼ");
		button_start.setFont(f2);
		button_start.setForeground(Color.white);
		                                     //��ť������ɫΪ��ɫ
		button_start.setBackground(c2);
		button_start.setOpaque(true);        
		               //setOpaqueIture)������Ŀ�����������ɲ�͸����
		               //������button_next�������õ���ɫ������ʾ������
		button_start.addActionListener(this);
		               //Ϊ����ʼ����ťע�ᶯ���¼�������
		
		button_reset=new JButton("��λ");
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
		
		this.setVisible(true);      //���ÿ�ܿ���
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
	
	//ʵ���߳���
	public void run()
	{
		while(true)
			try
		    {   
				//ʱ����ʾ�趨
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
				
				//�ı�����ʾʣ��ʱ��
				
				text_hour.setText(String.valueOf(hour));
				text_minute.setText(String.valueOf(minute));
				text_second.setText(String.valueOf(second));
				Thread.sleep(1000);         //�߳�˯��1��
				second--;
				
				//����ʱ���ʱ������ʱ��λ������ʾ���������Ի���
				if(hour==0&&minute==0&&second==-1)
				{
					button_start.setText("��ʼ");
					hour=0;
					minute=0;
					second=0;
					text_hour.setEditable(true);   //���ÿɱ༭
			        text_minute.setEditable(true);
			        text_second.setEditable(true);
					text_hour.setText(""+hour);
					text_minute.setText(""+minute);
					text_second.setText(""+second);
					num_control=0;
					
					java.awt.Toolkit.getDefaultToolkit().beep(); 
					JOptionPane.showMessageDialog(null, 
							              "����ʱ������");
					break;
				}
		    }
		
		    catch(InterruptedException ex)
		    {
		    	break;
		    }
	}
	
	//ʵ�ְ�ť�Ķ����¼��������ӿ�
	public void actionPerformed(ActionEvent ev)    
	{
		//���¡���λ����ťʱ
		if(ev.getSource()==button_reset)
		{
			button_start.setText("��ʼ");
			hour=0;
			minute=0;
			second=0;
			text_hour.setEditable(true);      //���ÿɱ༭
	        text_minute.setEditable(true);
	        text_second.setEditable(true);
			text_hour.setText(""+hour);
			text_minute.setText(""+minute);
			text_second.setText(""+second);
			num_control=0;
			thread.interrupt();
		}
		
		//���¡���ʼ������ͣ����ťʱ
		else if(ev.getSource()==button_start)
		{
			String str_hour,str_minute,str_second;
		    str_hour=text_hour.getText();
		    str_minute=text_minute.getText();
		    str_second=text_second.getText();
		
		    //ֻ������Ǹ�����ʱ��ʱ����ִ����ز��裬���򵯳���ʾ�Ի���
		    if(isNonNagativeInteger(str_hour)
		       &&isNonNagativeInteger(str_minute)
		       &&isNonNagativeInteger(str_second))
		    {
			    hour=Integer.parseInt(str_hour);
			    minute=Integer.parseInt(str_minute);
			    second=Integer.parseInt(str_second);
			    
			    if(hour==0&&minute==0&&second==0)
			    	JOptionPane.showMessageDialog(this, 
			    			      "����ʱ�䲻��Ϊ0��");
			    
			    //����ġ�ʱ������ΪС��24����������
			    //���֡��롰�롱����ΪС��60����������
			    else if(hour<24&&minute<60&&second<60)
			    {
			    	if(num_control==0)
			    	{
			    		text_hour.setEditable(false); 
			    		            //���ò��ɱ༭��ֻ������ʾ
				        text_minute.setEditable(false);
				        text_second.setEditable(false);
				        button_start.setText("��ͣ");
				        thread=new Thread(this);
				        thread.start();
				        num_control=1;
			    	}
			    	else if(num_control==1)
			    	{
			    		button_start.setText("��ʼ");
			    		num_control=0;
			    		thread.interrupt();
			    	}
				    
			    }
			    else
				    JOptionPane.showMessageDialog(this, 
				    		         "�����" +
				    		     "��ʱ������ΪС��24����������" +
				    		    "���֡��롰�롱����ΪС��60����������");
			}
		
		    else
			    JOptionPane.showMessageDialog(this, 
			    		"������������ʱ�䣡");
		}
	}
	
	public static void main(String arg[])
	{
		new CountdownTimer();   //�½���ܶ���
	}
}
