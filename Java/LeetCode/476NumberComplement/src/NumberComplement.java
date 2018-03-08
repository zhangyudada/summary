
public class NumberComplement {
	public int findComplement(int num) {
		int c, t = num;
		for(c = 0; (t & 0x80000000) == 0; t = t << 1)
			c++;
		return ~((0xFFFFFFFF << (32-c)) | num);
	}
	
	public static void main(String args[]) {
		//System.out.println(Integer.toBinaryString(new NumberComplement().findComplement(5)));
		System.out.print(new NumberComplement().findComplement(5));
	}

}