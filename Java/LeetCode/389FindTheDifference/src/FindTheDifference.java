
public class FindTheDifference {
	public char findDifference(String s, String t) {
		/*//solution 1
		for (int i = 0; i < s.length(); i++) {
			int index = t.indexOf(s.charAt(i));
			t = t.substring(0,index)+t.substring(index+1);
		}
		return t.charAt(0);*/
		
		/*//solution 2
		int sumCodeS = 0, sumCodeT = 0;
		for (int i = 0; i < s.length(); i++) sumCodeS += s.charAt(i);
		for (int i = 0; i < t.length(); i++) sumCodeT += t.charAt(i);
		return (char)(sumCodeT-sumCodeS);*/
		
		/*//optimization of solution 2
		int sumCode = t.charAt(s.length());
		for (int i = 0; i < s.length(); i++) {
			sumCode -= s.charAt(i);
			sumCode += t.charAt(i);
		}
		return (char)sumCode;*/
		
		//solution 3
		char c = t.charAt(s.length());
		for (int i = 0; i < s.length(); i++) {
			c ^= s.charAt(i);
			c ^= t.charAt(i);
		}
		return c;
	}
	
	public static void main(String args[]) {
		String s = "hello", t = "Welohl";
		System.out.print(new FindTheDifference().findDifference(s, t));
	}

}
