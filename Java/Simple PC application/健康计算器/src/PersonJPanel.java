import java.awt.*;
import javax.swing.*;
import javax.swing.border.TitledBorder;
public class PersonJPanel extends JPanel  //������Ϣ���
{
	static JTextField text_weight,text_height,text_yao;
	static JRadioButton rbm,rbw;   //��ѡ��ť
	public PersonJPanel()
	{
		this.setBorder(new TitledBorder("������Ϣ")); 
		                           //���������к�����ı߿���
		this.setLayout(new GridLayout(4,3,10,5));   
		                           //��岼�֣�4��3�У�
		                           //���ˮƽ���10���أ���ֱ���5����
		
		//��������ص������ӵ�����У���1��
		this.add(new JLabel("����",JLabel.RIGHT));
		text_weight=new JTextField("71");
		this.add(text_weight);
		this.add(new JLabel("kg"));
		
		//�������ص������ӵ�����У���2��
		this.add(new JLabel("���",JLabel.RIGHT));
		text_height=new JTextField("1.76");
		this.add(text_height);
		this.add(new JLabel("m"));
		
		//����Χ��ص������ӵ�����У���3��
		this.add(new JLabel("��Χ",JLabel.RIGHT));
		text_yao=new JTextField("90");
		this.add(text_yao);
		this.add(new JLabel("cm"));
		
		//���Ա���ص������ӵ�����У���4��
		this.add(new JLabel("�Ա�",JLabel.RIGHT));
		rbm=new JRadioButton("��");
		rbw=new JRadioButton("Ů");
		rbm.setSelected(true);   //����Ĭ�ϡ��С���ťѡ��
		ButtonGroup bg=new ButtonGroup();
		bg.add(rbm);
		bg.add(rbw);    //rbm��rbw������һ��ButtonGroup��ť���У�
		                //ʵ��rbm��rbw���⣬������ͬʱѡ��
	    this.add(rbm);
	    this.add(rbw);
	 
	}
}
