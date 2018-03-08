
public class ReverseString {
	public String reverseStrings(String s) {
		/*//solution 1
		if ( s == null || s.equals("")) return "";
		String rtn = "";
		for (int i = s.length(); i > 0; i--)
			rtn += s.substring(i-1, i);
		return rtn;*/
		
		/*//solution 2
		if ( s == null || s.equals("")) return "";
		return new StringBuffer(s).reverse().toString();*/
		
		//solution 3
		if ( s == null || s.equals("")) return "";
		char[] charArray = s.toCharArray();
		//for (int i = 0, j = a.length() - 1; i < j; i++, j--) { //needs 3ms
		for (int i = 0, j = charArray.length - 1; i < j; i++, j--) {
			char temp = charArray[i];
			charArray[i] = charArray[j];
			charArray[j] = temp;
		}
		return new String(charArray);

	}
	
	public static void main(String args[]) {
		String s = "i love java! ^_^";
		System.out.print(new ReverseString().reverseStrings(s));
	}

}
