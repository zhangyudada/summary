import java.awt.*;
import javax.swing.*;
import javax.swing.border.TitledBorder;
public class PersonJPanel extends JPanel  //基本信息面板
{
	static JTextField text_weight,text_height,text_yao;
	static JRadioButton rbm,rbw;   //单选按钮
	public PersonJPanel()
	{
		this.setBorder(new TitledBorder("基本信息")); 
		                           //设置面板带有含标题的边框线
		this.setLayout(new GridLayout(4,3,10,5));   
		                           //面板布局，4行3列，
		                           //组件水平间距10像素，垂直间距5像素
		
		//与体重相关的组件添加到面板中，第1行
		this.add(new JLabel("体重",JLabel.RIGHT));
		text_weight=new JTextField("71");
		this.add(text_weight);
		this.add(new JLabel("kg"));
		
		//与身高相关的组件添加到面板中，第2行
		this.add(new JLabel("身高",JLabel.RIGHT));
		text_height=new JTextField("1.76");
		this.add(text_height);
		this.add(new JLabel("m"));
		
		//与腰围相关的组件添加到面板中，第3行
		this.add(new JLabel("腰围",JLabel.RIGHT));
		text_yao=new JTextField("90");
		this.add(text_yao);
		this.add(new JLabel("cm"));
		
		//与性别相关的组件添加到面板中，第4行
		this.add(new JLabel("性别",JLabel.RIGHT));
		rbm=new JRadioButton("男");
		rbw=new JRadioButton("女");
		rbm.setSelected(true);   //设置默认“男”按钮选中
		ButtonGroup bg=new ButtonGroup();
		bg.add(rbm);
		bg.add(rbw);    //rbm与rbw包含到一个ButtonGroup按钮组中，
		                //实现rbm与rbw互斥，即不能同时选中
	    this.add(rbm);
	    this.add(rbw);
	 
	}
}
