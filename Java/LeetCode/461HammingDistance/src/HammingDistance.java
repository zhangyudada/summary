
public class HammingDistance {
	public int Hammingdistance(int x, int y) {
		int n = x ^ y;
		int c;
		/*for(c = 0; n > 0; n>>=1)
			c += n & 1;*/
		for(c = 0; n > 0; ++c)
			n &= (n-1);
		return c;	
	}
	
	public static void main(String args[]) {
		System.out.print(new HammingDistance().Hammingdistance(6,2));
	}

}
