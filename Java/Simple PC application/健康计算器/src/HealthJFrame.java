import javax.swing.*;
public class HealthJFrame extends JFrame
{
	protected PersonJPanel person=new PersonJPanel();
	protected Calculate calculate=new Calculate();
	public HealthJFrame()                  //�����ܵĹ��췽��
	{
		super("����������");                  //��ܱ���
		this.setSize(500,360);             //��ܴ�С����λ������
		this.setLocationRelativeTo(null);  //���ھ���
		this.setBackground(java.awt.Color.lightGray);  //��ܱ���ɫ
		this.setDefaultCloseOperation(EXIT_ON_CLOSE);  //�رտ��
		
		JSplitPane split=new 
		JSplitPane(JSplitPane.VERTICAL_SPLIT,true,person,calculate);
		                                   //��ֱ�ָ��Ϊ���������֣�
		                                   //�ϲ�ΪPersonJPanel()��һ������
		                                   //�²�ΪCalculate()��һ������
		                                   //�����������ָ����ƶ����ı��С
		split.setDividerLocation(180);     //�ָ���λ��
		this.getContentPane().add(split);  //�����ӷָ��
		this.setVisible(true);             //���ÿ�ܿ���
	}
	
	public static void main(String arg[])
	{
		new HealthJFrame();                //�½���ܶ���
	}
}
