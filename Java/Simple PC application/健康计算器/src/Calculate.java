import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.border.TitledBorder;
public class Calculate extends JPanel implements ActionListener
{
	private JTextField text_BMI,text_tizhi;
	private JButton button_BMI,button_tizhi;
	public Calculate()       //���㹦�����
	{
		this.setBorder(new TitledBorder("����"));    
		                     //���������б���ı߿���
		this.setLayout(new GridLayout(3,1,10,5));   
		                     //��岼�֣�3��1�У�
		                     //���ˮƽ���10���أ���ֱ���5����
		
		//BMIָ����������ʾ���
		JPanel panel1=new JPanel(new GridLayout(1,3,10,5)); 
		panel1.add(new JLabel("BMIָ��",JLabel.RIGHT));
		text_BMI=new JTextField();
		text_BMI.setEditable(false);  //���ò��ɱ༭��ֻ������ʾ
		panel1.add(text_BMI);
		panel1.add(new JLabel("kg/m2"));
		
		//��֬�ʼ�������ʾ���
		JPanel panel2=new JPanel(new GridLayout(1,3,10,5));
		panel2.add(new JLabel("��֬��",JLabel.RIGHT));
		text_tizhi=new JTextField();
		text_tizhi.setEditable(false);
		panel2.add(text_tizhi);
		panel2.add(new JLabel("%"));
		
		//��ť�����
		JPanel panel3=new JPanel(new GridLayout(1,5));  
		                      //����岼�֣�1��5�У�
		                      //������ť���ڵ�2�м���4�У��Եò��ֺ���
		panel3.add(new JLabel(""));
		button_BMI=new JButton("��BMIָ��");
		panel3.add(button_BMI);
		button_BMI.setBackground(Color.cyan);
		button_BMI.setOpaque(true);        
		           //setOpaqueIture)������Ŀ�����������ɲ�͸����
		           //������button_BMI�������õ���ɫ������ʾ������
		panel3.add(new JLabel(""));
		button_tizhi=new JButton("����֬��");
		button_tizhi.setBackground(Color.cyan);
		button_tizhi.setOpaque(true);
		panel3.add(button_tizhi);
		panel3.add(new JLabel(""));
		button_BMI.addActionListener(this);    
		          //Ϊ����BMIָ������ťע�ᶯ���¼�������
		button_tizhi.addActionListener(this);  
		          //Ϊ������֬�ʡ���ťע�ᶯ���¼�������
		
		//�����������������
		this.add(panel1);
		this.add(panel2);
		this.add(panel3);
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
		String str_weight,str_height,str_yao;
		str_weight=PersonJPanel.text_weight.getText();
		str_height=PersonJPanel.text_height.getText();
		str_yao=PersonJPanel.text_yao.getText();
		
		//ֻ����������������ʱ����ִ�������䣬���򵯳���ʾ�Ի���
		if(isNumber(str_weight)&&isNumber(str_height)&&isNumber(str_yao))
		{
		double w=Double.parseDouble(str_weight);
		double h=Double.parseDouble(str_height);
		double y=Double.parseDouble(str_yao);
		if(ev.getSource()==button_BMI)          //��������ť����BMIָ����
		{
			double bmi=w/(h*h);
			text_BMI.setText(""+Math.round(bmi*1000)/1000.0);
			                                    //������������λС��
			
			//������׼��Ϣ�Ի��򣬽��н�����ʾ
			if(bmi<=18.5)
				JOptionPane.showMessageDialog(null, "���ع��ᣬ�ǵò�Ҫ̫��Ŷ��");
			else if(bmi>18.5&&bmi<=23.9)
				JOptionPane.showMessageDialog(null, "�����������������ֹ�^_^");
			else if(bmi>23.9&&bmi<=27.9)
				JOptionPane.showMessageDialog(null, "�㳬������ע��Ҫ�����ˣ�");
			else if(bmi>27.9)
				JOptionPane.showMessageDialog(null, "���Ѿ����Ϸ���֢��");
		}
		else if(ev.getSource()==button_tizhi) //��������ť������֬�ʡ�
		{
			if(PersonJPanel.rbm.isSelected()) //����Ա�ѡ��ťѡ�е��ǡ��С�
			{
				double a,b,c,tizhi;
				a=y*0.74;
				b=w*0.082+44.74;
				c=a-b;
				tizhi=(c/w)*100;              //����������100��Ϊ�ٷ����ķ���
				text_tizhi.setText(""+Math.round(tizhi*1000)/1000.0);
				                              //�ٷ������ӱ�����λС��
			}
			else if(PersonJPanel.rbw.isSelected()) //����Ա�ѡ��ťѡ�е��ǡ�Ů��
			{
				double a,b,c,tizhi;
				a=y*0.74;
				b=w*0.082+34.89;
				c=a-b;
				tizhi=(c/w)*100;             //����������100��Ϊ�ٷ����ķ���
				text_tizhi.setText(""+Math.round(tizhi*1000)/1000.0);
				                             //�ٷ������ӱ�����λС��
			}	
		}
	}
		else
			JOptionPane.showMessageDialog(null, "���������ݣ����������֣�");
	}
}
