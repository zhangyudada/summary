
public class RemoveDuplicates {
	public int removeDuplicates(int[] nums) {
		if (nums == null || nums.length == 0) return 0;
		if (nums.length == 1) return 1;
		int insertPos = 0;
		for (int i = 0; i < nums.length-1; i++)
			if (nums[i] == nums [i+1]) {
				insertPos = i+1;
				break;
			}
		if (insertPos == 0) return nums.length;
		int curNum = nums[insertPos];
		for (int i = insertPos+1; i < nums.length; i++)
			if (curNum != nums[i])
				nums[insertPos++] = curNum = nums[i];
		return insertPos;
	}
	
	public static void main(String args[]) {
		int[] nums = {7,7};
		System.out.print(new RemoveDuplicates().removeDuplicates(nums));
	}

}
