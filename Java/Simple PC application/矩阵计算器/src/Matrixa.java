import java.awt.*;
import javax.swing.*;
import javax.swing.border.TitledBorder;

public class Matrixa extends JPanel  
{
	JTextField [][]a;
	
	//构造方法
	public Matrixa()
	{		
		this.setBorder(new TitledBorder("矩阵a（同时作为a+b与a*b的结果显示窗）"));
		                      //设置面板带有含标题的边框线
		this.setLayout(new GridLayout(10,10,10,5));   
                              //面板布局，10行10列，
                              //组件水平间距10像素，垂直间距5像素
		a = new JTextField[10][10];
		for(int m=0;m<10;m++)
			for(int n=0;n<10;n++)
			{
				a[m][n]=new JTextField();
				this.add(a[m][n]);
			}       //10*10的矩阵输入区
	}
}
