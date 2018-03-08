/***********************************************
 * Huffman����
 * ���룺��Դ������q,��Դ���ʷֲ�p
 * �����ÿ����Դ���Ŷ�Ӧ��Huffman���������
 * ʱ�䣺2015.06.13
 * ���ߣ�����
 ***********************************************/

import java.util.*;
public class Huffman {
	private static int q;			//������Դ�������ı���
	private static String p_char[];	//�ַ����飬�����ַ���ʽ����Դ����
	private static double p_num[];	//���������飬���渡������ʽ����Դ����
	
	//������Դ���ŵĸ����������浽����q��
	static void get_q(){
		System.out.println("��������Դ���Ÿ���q��");
	    Scanner input1;            	//���ڴӿ���̨��ȡ������ַ�
	    input1 = new Scanner(System.in);
	    try{
		    q = input1.nextInt();  	//���Խ�����̨������ַ�ת��Ϊ����
		    if(q<2){               	//Ҫ���������Դ��������С��2
			    System.out.println("�����벻С��2��������");
			    get_q();           	//������Ҫ����ݹ���ñ�����������������Դ���Ÿ���
		    }
	    }
	    //������̨����Ĳ��������ַ����򱨴����ݹ���ñ�����������������Դ���Ÿ���
	    catch(java.util.InputMismatchException ex){
		    System.out.println("����Ĳ�������������������.");
		    get_q();
	    }	
	}
	
	//������Դ���ʷֲ����������ַ�������p_char��
	static void get_p(int num){
		System.out.println("��������Դ���ʷֲ�p:��");
		Scanner input2;					//���ڴӿ���̨��ȡ������ַ�
		input2 = new Scanner(System.in);
		p_char = new String[num];		//Ϊ�ַ�������p_char�����ڴ�ռ�
		//�����ַ���
		for(int i = 0; i < num; i++) 
            p_char[i] = input2.nextLine();
		toDoubleArray(p_char,q);		//���ó�Ա����toDoubleArray()
										//���ַ���ʽ�ĸ��ʷֲ�ת��Ϊ������ʽ
	}
	
	//���ַ���ʽ�ĸ��ʷֲ�ת��Ϊ������ʽ�����浽����p_num��
	static void toDoubleArray(String str[],int num){
		//�ַ�����Ϊ�ջ򳤶�Ϊ0���򷵻ز�������
		if (str==null||str.length==0)
			return;
		p_num = new double[str.length];	//Ϊ����p_num�����ڴ�ռ�
		int i = 0;
		//���Խ��ַ�ת��Ϊ����
		while(i < str.length){
			try{
				p_num[i] = Double.parseDouble(str[i]);
			}
			catch(NumberFormatException ex){
				System.out.println(str[i]+"�ַ�����ת��Ϊ���֣����������룡");
				get_p(num);
				return;
			}
			catch(Exception ex){
				ex.printStackTrace();
				return;
			}
			finally{i++;}
		}
		//�ж�����ĸ��ʷֲ��Ƿ�����0~1֮���Ҫ��
		for(i = 0;i < q;i++)
			if(p_num[i]<0.0||p_num[i]>1.0){
				System.out.println("������ʱ���Ϊ0��1֮����������������룡");
				get_p(num);
				return;
			}
		//�ж�����ĸ��ʷֲ����Ƿ�Ϊ1
		double sum = 0.0;				//������Դ���ʺ͵ı���
		final double DELTA = 1.0e-6;	//����ֵ�������ж�������Դ���ʺ��Ƿ�Ϊ1.0
		for(i=0;i<q;i++)
			sum += p_num[i];
		if(Math.abs(sum-1.0)>DELTA){
			System.out.println("����ĸ��ʺͲ�Ϊ1�����������룡");
			get_p(num);
			return;
		}
	}
	
	//��ʾ��Դ���ʷֲ�
	static void display_p(double num[]){
		System.out.print("��Դ���ʷֲ�Ϊp��");
		for(int i = 0;i < num.length;i++)
			System.out.print(num[i]+" ");
		System.out.println();
	}
	
	//��ʾ��Դ��Huffman����
	static void display_code(HCodeType HuffCode[]){
		System.out.print("һ��Huffman����Ϊ��");
		int i,j;
		for(i = 0;i < q;i++){
			for(j = HuffCode[i].start;j < q;j++)
				System.out.print(HuffCode[i].bit[j]);
			System.out.print(" ");
		}
		System.out.println();
	}
	
	//���ø�������p_num����Huffman�������洢�ڶ�������HFMTree[]��
	static void Create_HuffMTree(HNodeType HFMTree[],double p_num[],int q){
		final double MAX = 2.0;	//Ϊ�ҵ���С�ʹ�С����
								//����һ���������п��ܸ��ʣ�����1.0������
		int min1,min2;			//min1��min2�ֱ�洢��С�ʹ�СȨֵ��λ��
		double weight1,weight2;	//weight1��weight2�ֱ�洢��С�ʹ�С��Ȩֵ
		int i,j;
		
		//HFMTree��ʼ����Huffman�������Ϊ2*q-1��
		for(i = 0;i < 2*q-1;i++){
			HFMTree[i].weight = 0;
			HFMTree[i].parent = -1;	//������parentֵΪ-1
			HFMTree[i].lchild = -1;
			HFMTree[i].rchild = -1;
		}
		//HFMTreeǰn����ȨֵΪp_num��Ӧ�ĸ���
		for(i = 0;i < q;i++)
			HFMTree[i].weight = p_num[i];
		
		for(i = 0;i < q-1;i++){
			weight1 = weight2 = MAX;
			min1 = min2 = 0;
			//�ҳ�����������С�ʹ�СȨֵ��������
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
			//���ҵ������������ϲ�Ϊһ������
			HFMTree[min1].parent = q+i;
			HFMTree[min2].parent = q+i;
			HFMTree[q+i].weight = HFMTree[min1].weight + HFMTree[min2].weight;
			HFMTree[q+i].lchild = min1;
			HFMTree[q+i].rchild = min2;
		}
	}
	
	//���ݶ�������HFMTree[]����Huffman���룬�洢�ڶ�������HuffCode[]��
	static void HuffmanCode(HNodeType HFMTree[],HCodeType HuffCode[]){
		HCodeType code = new HCodeType();	//�ַ�����Ļ������
		int i,j;
		int child,parent;
		//��ÿ��Ҷ�ӽ���Huffman����
		for(i = 0;i < q;i++){
			code.start = q-1;
			child = i;
			parent = HFMTree[child].parent;
			//��Ҷ�ӽ������ֱ������
			while(parent != -1){
				if(HFMTree[parent].lchild == child)
					code.bit[code.start] = '0';
				else
					code.bit[code.start] = '1';
				code.start--;
				child = parent;
				parent = HFMTree[child].parent;
			}
			//���������ÿ��Ҷ�ӽ���Huffman����ͱ�����ʼλ��
			for(j = code.start+1;j < q;j++)
				HuffCode[i].bit[j] = code.bit[j];
			HuffCode[i].start = code.start+1;
		}
	}
	
	
	//������
	public static void main(String args[]){
		int i;
		
		get_q();			//��ȡ��Դ������
		get_p(q);			//��ȡ��Դ���ʷֲ�
		display_p(p_num);	//��ʾ��Դ���ʷֲ�
		//����Huffman��
		HNodeType HFMTree[] = new HNodeType[2*q-1];
		for(i = 0;i < 2*q-1;i++)
			HFMTree[i] = new HNodeType();
		Create_HuffMTree(HFMTree,p_num,q);
		//����Huffamn����
		HCodeType HuffCode[] = new HCodeType[q];
		for(i = 0;i < q;i++)
			HuffCode[i] = new HCodeType();
		HuffmanCode(HFMTree,HuffCode);
		//��ʾ��Դ��Huffman����
		display_code(HuffCode);
	}
}

//��̬��������ݽṹ���洢Huffman������
class HNodeType{
	double weight;	//���Ȩֵ
	int parent;		//���ĸ����
	int lchild;		//��������
	int rchild;		//�����Һ���
}

//���Huffman������Ϣ����
class HCodeType{
	char[] bit = new char[10];	//һ����Դ���ŵ�Huffman��������
	int start;					//����Դ����Huffman������bit�����е���ʼλ��
}
