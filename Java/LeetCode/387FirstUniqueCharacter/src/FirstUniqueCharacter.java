
public class FirstUniqueCharacter {
	public int firstUniqChar(String s) {
		//ͬ#283˼��
		if (s == null) return -1;
		int[] letters = new int[26];
		for (int i = 0; i < s.length(); i++)
			letters[s.charAt(i) - 'a']++;
		for (int i = 0; i < s.length(); i++)
			if (letters[s.charAt(i)-'a'] == 1) return i;
		return -1;
	}
	
	public static void main(String args[]) {
		String s = "aca";
		System.out.print(new FirstUniqueCharacter().firstUniqChar(s));
	}

}
