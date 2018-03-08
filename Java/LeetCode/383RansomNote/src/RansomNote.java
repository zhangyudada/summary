
public class RansomNote {
	public boolean canConstruct(String ransomNote, String magazine) {
		/*char[] ranChar = ransomNote.toCharArray();
		char[] magChar = magazine.toCharArray();
		Arrays.sort(ranChar);
		Arrays.sort(magChar);
		ransomNote = String.valueOf(ranChar);
		magazine = String.valueOf(magChar);
		if (magazine.indexOf(ransomNote) != -1) return true;
		else return false;*/
		
		//Í¬#387Ë¼Ïë
		int[] letters = new int[26];
		for (int i = 0; i < magazine.length(); i++)
			letters[magazine.charAt(i)-'a']++;
		for (int i = 0; i < ransomNote.length(); i++)
			if (--letters[ransomNote.charAt(i)-'a'] < 0) return false;
		return true;
	}
	
	public static void main(String args[]) {
		String ransomNote = "amn";
		String magazine = "dmtna";
		System.out.print(new RansomNote().canConstruct(ransomNote, magazine));
	}

}
