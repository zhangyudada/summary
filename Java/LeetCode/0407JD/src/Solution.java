import java.util.Scanner;

public class Solution {
	public int convert(String n, String sx, String sy){
		int dx = 0, dy = 0;
		for(char c: sx.toCharArray())
			dx = dx * 2 + (c == '1' ? 1 : 0);
		for(char c: sy.toCharArray())
			dy = dy * 2 + (c == '1' ? 1 : 0);
		return dx^dy;
	}
	
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String n = sc.nextLine();
		String x = sc.nextLine();		
		String y = sc.nextLine();
		System.out.print(new Solution().convert(n, x, y));
	}

}
