import java.awt.*;
import javax.swing.*;
import javax.swing.border.TitledBorder;

public class Matrixa extends JPanel  
{
	JTextField [][]a;
	
	//���췽��
	public Matrixa()
	{		
		this.setBorder(new TitledBorder("����a��ͬʱ��Ϊa+b��a*b�Ľ����ʾ����"));
		                      //���������к�����ı߿���
		this.setLayout(new GridLayout(10,10,10,5));   
                              //��岼�֣�10��10�У�
                              //���ˮƽ���10���أ���ֱ���5����
		a = new JTextField[10][10];
		for(int m=0;m<10;m++)
			for(int n=0;n<10;n++)
			{
				a[m][n]=new JTextField();
				this.add(a[m][n]);
			}       //10*10�ľ���������
	}
}
