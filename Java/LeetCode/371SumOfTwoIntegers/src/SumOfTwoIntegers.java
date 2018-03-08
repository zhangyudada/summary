
public class SumOfTwoIntegers {
	public int getSum(int a, int b) {
		return b==0 ? a : getSum(a^b, (a&b)<<1);
	}
	
	public static void main(String args[]) {
		System.out.print(new SumOfTwoIntegers().getSum(-1,1));
	}

}
