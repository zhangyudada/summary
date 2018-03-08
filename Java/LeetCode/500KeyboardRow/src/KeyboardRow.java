
public class KeyboardRow {
	public String[] findWords(String[] words) {
		String k1 = "qwertyuiop";
		String k2 = "asdfghjkl";
		String k3 = "zxcvbnm";
		String s;
		int[] index = new int[words.length];
		for(int i = 0; i < words.length; i++) {
			index[i] = i;
		}
		
		for(int i = 0; i < words.length; i++) {
			s = words[i].toLowerCase();
			
			if( k1.indexOf(s.substring(0, 1)) != -1 ) {
				for(int j = 1; j < s.length(); j++)
					if( k1.indexOf(s.substring(j, j+1)) == -1 ) {
						index[i] = -1; break;
					}
			}
					
			else if( k2.indexOf(s.substring(0, 1)) != -1 ) {
				for(int j = 1; j < s.length(); j++)
					if( k2.indexOf(s.substring(j, j+1)) == -1 ) {
						index[i] = -1; break;
					}
			}
			
			else {
				for(int j = 1; j < s.length(); j++)
					if( k3.indexOf(s.substring(j, j+1)) == -1 ) {
						index[i] = -1; break;
					}
			}		
		}
		
		String[] rtn_s = new String[words.length];
		int rtn_num = 0;
		for(int i = 0; i < index.length; i++)
			if(index[i] != -1) {
				rtn_s[rtn_num] = words[i];
				rtn_num++;
			}

		String[] rtn = new String[rtn_num];
		for(int i = 0; i < rtn_num; i++)
			rtn[i] = rtn_s[i];
		return rtn;	
	}
	
	public static void main(String args[]) {
		String[] words = {"Hello", "Alaska", "Dad", "Peace", "NB", "were", "Poor"};
		for(int i = 0; i < new KeyboardRow().findWords(words).length; i++)
			System.out.print(new KeyboardRow().findWords(words)[i]+" ");
	}

}
