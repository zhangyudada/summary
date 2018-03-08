import javax.swing.*;

public class MatrixCalculator extends JFrame 
{
	private Matrixa matrixa=new Matrixa();
	private Matrixb matrixb=new Matrixb(matrixa);
	
	public MatrixCalculator()              //�����ܵĹ��췽��
	{
		super("���������");                  //��ܱ���
		this.setSize(1000,700);            //��ܴ�С����λ������
		this.setLocationRelativeTo(null);  //���ھ���
		this.setBackground(java.awt.Color.lightGray);  //��ܱ���ɫ
		this.setDefaultCloseOperation(EXIT_ON_CLOSE);  //�رտ��
		
		JSplitPane split=new 
		JSplitPane(JSplitPane.VERTICAL_SPLIT,true,
				    matrixa,matrixb);
		                                   //��ֱ�ָ��Ϊ���������֣�
		                                   //�ϲ�Ϊmatrixa����
		                                   //�²�Ϊmatrixb����
		                                   //�����������ָ����ƶ����ı��С
		split.setDividerLocation(310);     //�ָ���λ��
		this.getContentPane().add(split);  //�����ӷָ��
		this.setVisible(true);             //���ÿ�ܿ���
	}
	
	public static void main(String arg[])
	{
		new MatrixCalculator();                //�½���ܶ���
	}

}
