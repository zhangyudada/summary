
public class RemoveElement {
	public int removeElement(int[] nums, int val) {
		if (nums == null || nums.length == 0) return 0;
		int insertPos = -1;
		for (int i = 0; i < nums.length; i++)
			if (val == nums[i]) {
				insertPos = i;
				break;
			}
		if (insertPos == -1) return nums.length;
		for (int i = insertPos+1; i < nums.length; i++)
			if (val != nums[i])
				nums[insertPos++] = nums[i];
		return insertPos;
	}
	
	public static void main(String args[]) {
		int[] nums = {7};
		int val = 7;
		System.out.print(new RemoveElement().removeElement(nums, val));
	}

}
