
public class PlusOne {
	public int[] plusOne(int[] digits) {
		int l = digits.length;
		int c = 1;
		for (int i = l-1; i > 0; i--)
			if (c == 1 && digits[i] != 9) {
				digits[i]++;
				c = 0;
				return digits;
			} else if (c == 1 && digits[i] == 9)
				digits[i] = 0;
		if (digits[0] != 9) {
			digits[0]++;
			return digits;
		}
		else {
			digits[0] = 0;
			int[] rtn = new int[l+1];
			rtn[0] = 1;
			for (int i = 0; i < l; i++)
				rtn[i+1] = digits[i];
			return rtn;	
		}
	}
	
	public static void main(String args[]) {
		int[] digits = {1,6,9};
		int[] tmp = new PlusOne().plusOne(digits);
		for (int i = 0; i < tmp.length; i++)
			System.out.print(tmp[i]+" ");
	}

}
