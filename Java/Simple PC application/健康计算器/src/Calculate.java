import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.border.TitledBorder;
public class Calculate extends JPanel implements ActionListener
{
	private JTextField text_BMI,text_tizhi;
	private JButton button_BMI,button_tizhi;
	public Calculate()       //计算功能面板
	{
		this.setBorder(new TitledBorder("计算"));    
		                     //设置面板带有标题的边框线
		this.setLayout(new GridLayout(3,1,10,5));   
		                     //面板布局，3行1列，
		                     //组件水平间距10像素，垂直间距5像素
		
		//BMI指数计算结果显示面板
		JPanel panel1=new JPanel(new GridLayout(1,3,10,5)); 
		panel1.add(new JLabel("BMI指数",JLabel.RIGHT));
		text_BMI=new JTextField();
		text_BMI.setEditable(false);  //设置不可编辑，只用于显示
		panel1.add(text_BMI);
		panel1.add(new JLabel("kg/m2"));
		
		//体脂率计算结果显示面板
		JPanel panel2=new JPanel(new GridLayout(1,3,10,5));
		panel2.add(new JLabel("体脂率",JLabel.RIGHT));
		text_tizhi=new JTextField();
		text_tizhi.setEditable(false);
		panel2.add(text_tizhi);
		panel2.add(new JLabel("%"));
		
		//按钮子面板
		JPanel panel3=new JPanel(new GridLayout(1,5));  
		                      //子面板布局，1行5列，
		                      //两个按钮放在第2列及第4列，显得布局合理
		panel3.add(new JLabel(""));
		button_BMI=new JButton("求BMI指数");
		panel3.add(button_BMI);
		button_BMI.setBackground(Color.cyan);
		button_BMI.setOpaque(true);        
		           //setOpaqueIture)方法的目的是让组件变成不透明，
		           //这样在button_BMI上所设置的颜色才能显示出来。
		panel3.add(new JLabel(""));
		button_tizhi=new JButton("求体脂率");
		button_tizhi.setBackground(Color.cyan);
		button_tizhi.setOpaque(true);
		panel3.add(button_tizhi);
		panel3.add(new JLabel(""));
		button_BMI.addActionListener(this);    
		          //为“求BMI指数”按钮注册动作事件监听器
		button_tizhi.addActionListener(this);  
		          //为“求体脂率”按钮注册动作事件监听器
		
		//主面板添加三个子面板
		this.add(panel1);
		this.add(panel2);
		this.add(panel3);
	}
	
	//判断字符串是否为整数
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
		 
		//判断字符串是否为浮点数
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
		
		//判断字符串是否为数字
		 public static boolean isNumber(String value) 
		 {
			 return isInteger(value) || isDouble(value);
		 }
	
	//实现按钮的动作事件监听器接口
	public void actionPerformed(ActionEvent ev) 
	{
		String str_weight,str_height,str_yao;
		str_weight=PersonJPanel.text_weight.getText();
		str_height=PersonJPanel.text_height.getText();
		str_yao=PersonJPanel.text_yao.getText();
		
		//只有在输入数字数据时，才执行相关语句，否则弹出提示对话框
		if(isNumber(str_weight)&&isNumber(str_height)&&isNumber(str_yao))
		{
		double w=Double.parseDouble(str_weight);
		double h=Double.parseDouble(str_height);
		double y=Double.parseDouble(str_yao);
		if(ev.getSource()==button_BMI)          //如果点击按钮“求BMI指数”
		{
			double bmi=w/(h*h);
			text_BMI.setText(""+Math.round(bmi*1000)/1000.0);
			                                    //计算结果保留三位小数
			
			//弹出标准消息对话框，进行健康提示
			if(bmi<=18.5)
				JOptionPane.showMessageDialog(null, "体重过轻，记得不要太瘦哦！");
			else if(bmi>18.5&&bmi<=23.9)
				JOptionPane.showMessageDialog(null, "体重正常，继续保持哈^_^");
			else if(bmi>23.9&&bmi<=27.9)
				JOptionPane.showMessageDialog(null, "你超重啦，注意要减肥了！");
			else if(bmi>27.9)
				JOptionPane.showMessageDialog(null, "你已经患上肥胖症！");
		}
		else if(ev.getSource()==button_tizhi) //如果点击按钮“求体脂率”
		{
			if(PersonJPanel.rbm.isSelected()) //如果性别单选按钮选中的是“男”
			{
				double a,b,c,tizhi;
				a=y*0.74;
				b=w*0.082+44.74;
				c=a-b;
				tizhi=(c/w)*100;              //计算结果乘以100作为百分数的分子
				text_tizhi.setText(""+Math.round(tizhi*1000)/1000.0);
				                              //百分数分子保留三位小数
			}
			else if(PersonJPanel.rbw.isSelected()) //如果性别单选按钮选中的是“女”
			{
				double a,b,c,tizhi;
				a=y*0.74;
				b=w*0.082+34.89;
				c=a-b;
				tizhi=(c/w)*100;             //计算结果乘以100作为百分数的分子
				text_tizhi.setText(""+Math.round(tizhi*1000)/1000.0);
				                             //百分数分子保留三位小数
			}	
		}
	}
		else
			JOptionPane.showMessageDialog(null, "请输入数据，数据是数字！");
	}
}
