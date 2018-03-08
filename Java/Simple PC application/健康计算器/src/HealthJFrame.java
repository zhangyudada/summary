import javax.swing.*;
public class HealthJFrame extends JFrame
{
	protected PersonJPanel person=new PersonJPanel();
	protected Calculate calculate=new Calculate();
	public HealthJFrame()                  //顶层框架的构造方法
	{
		super("健康计算器");                  //框架标题
		this.setSize(500,360);             //框架大小，单位是像素
		this.setLocationRelativeTo(null);  //窗口居中
		this.setBackground(java.awt.Color.lightGray);  //框架背景色
		this.setDefaultCloseOperation(EXIT_ON_CLOSE);  //关闭框架
		
		JSplitPane split=new 
		JSplitPane(JSplitPane.VERTICAL_SPLIT,true,person,calculate);
		                                   //垂直分割窗格为上下两部分，
		                                   //上部为PersonJPanel()的一个对象，
		                                   //下部为Calculate()的一个对象，
		                                   //窗格中组件随分割线移动而改变大小
		split.setDividerLocation(180);     //分割线位置
		this.getContentPane().add(split);  //框架添加分割窗格
		this.setVisible(true);             //设置框架可视
	}
	
	public static void main(String arg[])
	{
		new HealthJFrame();                //新建框架对象
	}
}
