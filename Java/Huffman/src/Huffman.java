/***********************************************
 * Huffman编码
 * 输入：信源符号数q,信源概率分布p
 * 输出：每个信源符号对应的Huffman编码的码字
 * 时间：2015.06.13
 * 作者：张宇
 ***********************************************/

import java.util.*;
public class Huffman {
	private static int q;			//保存信源符号数的变量
	private static String p_char[];	//字符数组，保存字符形式的信源概率
	private static double p_num[];	//浮点数数组，保存浮点数形式的信源概率
	
	//输入信源符号的个数，并保存到变量q中
	static void get_q(){
		System.out.println("请输入信源符号个数q：");
	    Scanner input1;            	//用于从控制台获取输入的字符
	    input1 = new Scanner(System.in);
	    try{
		    q = input1.nextInt();  	//尝试将控制台输入的字符转换为整数
		    if(q<2){               	//要求输入的信源符号数不小于2
			    System.out.println("请输入不小于2的整数！");
			    get_q();           	//不符合要求则递归调用本方法，重新输入信源符号个数
		    }
	    }
	    //若控制台输入的不是整数字符，则报错，并递归调用本方法，重新输入信源符号个数
	    catch(java.util.InputMismatchException ex){
		    System.out.println("输入的不是整数，请重新输入.");
		    get_q();
	    }	
	}
	
	//输入信源概率分布，保存在字符串数组p_char中
	static void get_p(int num){
		System.out.println("请输入信源概率分布p:：");
		Scanner input2;					//用于从控制台获取输入的字符
		input2 = new Scanner(System.in);
		p_char = new String[num];		//为字符串数组p_char申请内存空间
		//读入字符串
		for(int i = 0; i < num; i++) 
            p_char[i] = input2.nextLine();
		toDoubleArray(p_char,q);		//调用成员方法toDoubleArray()
										//将字符形式的概率分布转换为数字形式
	}
	
	//将字符形式的概率分布转换为数字形式，并存到数组p_num中
	static void toDoubleArray(String str[],int num){
		//字符数组为空或长度为0，则返回不做处理
		if (str==null||str.length==0)
			return;
		p_num = new double[str.length];	//为数组p_num申请内存空间
		int i = 0;
		//尝试将字符转换为数字
		while(i < str.length){
			try{
				p_num[i] = Double.parseDouble(str[i]);
			}
			catch(NumberFormatException ex){
				System.out.println(str[i]+"字符不能转换为数字，请重新输入！");
				get_p(num);
				return;
			}
			catch(Exception ex){
				ex.printStackTrace();
				return;
			}
			finally{i++;}
		}
		//判断输入的概率分布是否满足0~1之间的要求
		for(i = 0;i < q;i++)
			if(p_num[i]<0.0||p_num[i]>1.0){
				System.out.println("输入概率必须为0到1之间的数，请重新输入！");
				get_p(num);
				return;
			}
		//判断输入的概率分布和是否为1
		double sum = 0.0;				//保存信源概率和的变量
		final double DELTA = 1.0e-6;	//精度值，用于判断输入信源概率和是否为1.0
		for(i=0;i<q;i++)
			sum += p_num[i];
		if(Math.abs(sum-1.0)>DELTA){
			System.out.println("输入的概率和不为1，请重新输入！");
			get_p(num);
			return;
		}
	}
	
	//显示信源概率分布
	static void display_p(double num[]){
		System.out.print("信源概率分布为p：");
		for(int i = 0;i < num.length;i++)
			System.out.print(num[i]+" ");
		System.out.println();
	}
	
	//显示信源的Huffman编码
	static void display_code(HCodeType HuffCode[]){
		System.out.print("一种Huffman编码为：");
		int i,j;
		for(i = 0;i < q;i++){
			for(j = HuffCode[i].start;j < q;j++)
				System.out.print(HuffCode[i].bit[j]);
			System.out.print(" ");
		}
		System.out.println();
	}
	
	//利用概率数组p_num构造Huffman树，并存储于对象数组HFMTree[]中
	static void Create_HuffMTree(HNodeType HFMTree[],double p_num[],int q){
		final double MAX = 2.0;	//为找到最小和次小概率
								//先设一个大于所有可能概率（大于1.0）的数
		int min1,min2;			//min1和min2分别存储最小和次小权值的位置
		double weight1,weight2;	//weight1和weight2分别存储最小和次小的权值
		int i,j;
		
		//HFMTree初始化，Huffman树结点数为2*q-1个
		for(i = 0;i < 2*q-1;i++){
			HFMTree[i].weight = 0;
			HFMTree[i].parent = -1;	//根结点的parent值为-1
			HFMTree[i].lchild = -1;
			HFMTree[i].rchild = -1;
		}
		//HFMTree前n个的权值为p_num对应的概率
		for(i = 0;i < q;i++)
			HFMTree[i].weight = p_num[i];
		
		for(i = 0;i < q-1;i++){
			weight1 = weight2 = MAX;
			min1 = min2 = 0;
			//找出根结点具有最小和次小权值的两棵树
			for(j = 0;j < q+i;j++){
				if(HFMTree[j].parent == -1 && HFMTree[j].weight < weight1){
					weight2 = weight1;
					min2 = min1;
					weight1 = HFMTree[j].weight;
					min1 = j;
				}
				else if(HFMTree[j].parent == -1 && HFMTree[j].weight < weight2){
					weight2 = HFMTree[j].weight;
					min2 = j;
				}
			}
			//将找到的两颗子树合并为一棵子树
			HFMTree[min1].parent = q+i;
			HFMTree[min2].parent = q+i;
			HFMTree[q+i].weight = HFMTree[min1].weight + HFMTree[min2].weight;
			HFMTree[q+i].lchild = min1;
			HFMTree[q+i].rchild = min2;
		}
	}
	
	//根据对象数组HFMTree[]构造Huffman编码，存储在对象数组HuffCode[]中
	static void HuffmanCode(HNodeType HFMTree[],HCodeType HuffCode[]){
		HCodeType code = new HCodeType();	//字符编码的缓冲对象
		int i,j;
		int child,parent;
		//求每个叶子结点的Huffman编码
		for(i = 0;i < q;i++){
			code.start = q-1;
			child = i;
			parent = HFMTree[child].parent;
			//有叶子结点向上直到树根
			while(parent != -1){
				if(HFMTree[parent].lchild == child)
					code.bit[code.start] = '0';
				else
					code.bit[code.start] = '1';
				code.start--;
				child = parent;
				parent = HFMTree[child].parent;
			}
			//保存求出的每个叶子结点的Huffman编码和编码起始位置
			for(j = code.start+1;j < q;j++)
				HuffCode[i].bit[j] = code.bit[j];
			HuffCode[i].start = code.start+1;
		}
	}
	
	
	//主函数
	public static void main(String args[]){
		int i;
		
		get_q();			//获取信源符号数
		get_p(q);			//获取信源概率分布
		display_p(p_num);	//显示信源概率分布
		//构造Huffman树
		HNodeType HFMTree[] = new HNodeType[2*q-1];
		for(i = 0;i < 2*q-1;i++)
			HFMTree[i] = new HNodeType();
		Create_HuffMTree(HFMTree,p_num,q);
		//构造Huffamn编码
		HCodeType HuffCode[] = new HCodeType[q];
		for(i = 0;i < q;i++)
			HuffCode[i] = new HCodeType();
		HuffmanCode(HFMTree,HuffCode);
		//显示信源的Huffman编码
		display_code(HuffCode);
	}
}

//静态链表的数据结构，存储Huffman树的类
class HNodeType{
	double weight;	//结点权值
	int parent;		//结点的父结点
	int lchild;		//结点的左孩子
	int rchild;		//结点的右孩子
}

//存放Huffman编码信息的类
class HCodeType{
	char[] bit = new char[10];	//一个信源符号的Huffman编码数组
	int start;					//该信源符号Huffman编码在bit数组中的起始位置
}
