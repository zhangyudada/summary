
public class MoveZeroes {
	public int[] moveZeros(int[] nums) {
		/*//sllution 1
		int index = 0;
		for (int i = 0; i < nums.length-index; i++) {
			if (nums[i] == 0) {
				for (int j = i; j < nums.length-index-1; j++) {
					nums[j] = nums[j+1];
					nums[j+1] = 0;
				}
				index++;
				i--;
			}
		}
		return nums;*/
		
		//solution 2
		if (nums == null || nums.length == 0) return null;
		int insertPos = 0;
		for (int i = 0; i < nums.length; i++)
			if (nums[i] != 0) nums[insertPos++] = nums[i];
		while (insertPos < nums.length)
			nums[insertPos++] = 0;
		return nums;
	}
	
	public static void main(String args[]) {
		int[] nums = {1,0,0,1};
		for (int i = 0; i < nums.length; i++)
			System.out.print(new MoveZeroes().moveZeros(nums)[i]+" ");
	}

}
