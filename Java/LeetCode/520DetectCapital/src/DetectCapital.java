
public class DetectCapital {
	public boolean detectCaptialUse(String word) {
		/*//solution 1
		//第一次提交没加这句话，结果输入“G”时产生数组下标越界错误
		if (word.length() == 1 || word.length() == 0) return true;
		char[] charArray = word.toCharArray();
		boolean flag = true;
		if (charArray[0] >= 65 && charArray[0] <= 90) {
			if(charArray[1] >= 65 && charArray[1] <= 90) {
				for (int i = 2; i < charArray.length; i++)
					if (charArray[i] > 90 || charArray[i] < 65) {
						flag = false; break;
					}
			}
			else
				for (int i = 2; i < charArray.length; i++)
					if (charArray[i] >= 65 && charArray[i] <= 90) {
						flag = false; break;
					}
		}
		else
			for (int i = 1; i < charArray.length; i++)
				if (charArray[i] >= 65 && charArray[i] <= 90) {
					flag = false; break;
				}
		return flag;*/
		
		//solution 2
				int numUpper = 0;
				for (int i = 0; i < word.length(); i++)
					if (Character.isUpperCase(word.charAt(i))) numUpper++;
				if (numUpper == 1) return Character.isUpperCase(word.charAt(0));
				return numUpper == 0 || numUpper == word.length();
		
		/*//solution 3
		return  word.toUpperCase().equals(word) ||
				word.toLowerCase().equals(word) || 
				Character.isUpperCase(word.charAt(0)) && 
				word.substring(1).toLowerCase().equals(word.substring(1));*/
	}
	
	public static void main(String args[]) {
		String word = "C";
		System.out.print(new DetectCapital().detectCaptialUse(word));
	}

}
