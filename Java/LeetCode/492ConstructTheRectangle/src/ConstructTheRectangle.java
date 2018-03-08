
public class ConstructTheRectangle {
	public int[] constructRectangle(int area) {
		double sqrt = Math.sqrt(area);
		if (sqrt%1.0 == 0) {
			int L = (int)sqrt;
			int[] rtn = {L, L};
			return rtn;
		}
		for (int i = (int)sqrt; i > 0; i--)
			if (area%i == 0) {
				int[] rtn = {area/i, i};
				return rtn;
			}
		return null;
	}
	
	public static void main(String args[]) {
		int area = 2048;
		System.out.println(new ConstructTheRectangle().constructRectangle(area)[0]);
		System.out.print(new ConstructTheRectangle().constructRectangle(area)[1]);
	}

}
