
public class Base7 {
	public String convertToBase7(int num) {
		if (num == 0) return "0";
		//StringBuffer sb = new StringBuffer();
		StringBuilder sb = new StringBuilder();
		boolean isNegative = num < 0; 
		num = Math.abs(num);
		while (num != 0) {
			sb.append((num%7)+"");
			num = num/7;
		}
		if (isNegative) sb.append("-");
		sb.reverse();
		return sb.toString();
	}
	
	public static void main(String args[]) {
		int num = -18;
		System.out.print(new Base7().convertToBase7(num));
	}

}
