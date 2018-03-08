
public class AddDigits {
	public int addDigits(int num) {
		return (num-1)%9+1;
	}
	
	public static void main(String args[]) {
		System.out.print(new AddDigits().addDigits(25));
	}

}
