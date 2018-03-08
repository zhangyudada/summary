import java.util.Scanner;


public class NetEase {
	public static int jisuan(int x, char ch, int y) {
		switch (ch) {
			case '+': return x+y;
			case '-': return x-y; 
			case '*': return x*y; 
		}
		return 0;
	}
	
	public static void main(String args[]) {
		Scanner sc = new Scanner(System.in);
		String line; 
        line = sc.nextLine(); 

		 
		 int a , b, i = 0;
		 char ch;
		 a = Integer.parseInt(line.charAt(0)+"");
		 
		 while (i < line.length()-2) {
			 ch = line.charAt(i+1);
			 b = Integer.parseInt(line.charAt(i+2)+"");
			 a = jisuan(a,ch,b);
			 i=i+2;
		 }
		
		 System.out.print(a);
	}
}




