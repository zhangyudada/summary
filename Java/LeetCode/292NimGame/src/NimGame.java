
public class NimGame {
	public boolean canWinNim(int n) {
		//谁碰到剩余4的整数倍个石头就必输无疑
		//我先走，n为4的整数倍是我必输；若不是，我先拿若干个使得剩余石头数为4的整数倍，则我必赢
		return n % 4 != 0;
	}
	
	public static void main(String args[]) {
		System.out.print(new NimGame().canWinNim(3));
	}

}
