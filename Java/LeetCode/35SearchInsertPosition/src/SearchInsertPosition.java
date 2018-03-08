
public class SearchInsertPosition {
	public int searchInsert(int[] nums, int target) {
		/*//solution 1
		if (nums == null || nums.length == 0) return 0;
		if (nums[nums.length-1] < target) return nums.length;
		for (int i = 0; i < nums.length; i++) {
			if (nums[i] == target) return i;
			if (nums[i] < target) continue;
			if (nums[i] > target) return i;
		}
		return 0;*/
		
		//solution 2
		if (nums == null || nums.length == 0) return 0;
		if (nums[nums.length-1] < target) return nums.length;
		int low = 0, high = nums.length - 1;
		int mid;
		while (low <= high) {
			mid = (low+high)/2;
			if (nums[mid] == target) return mid;
			else if (nums[mid] > target) high = mid - 1;
			else low = mid + 1;	
		}
		return low;
	}
	
	public static void main(String args[]) {
		int[] nums = {1,3,5,7};
		int target = 6;
		System.out.print(new SearchInsertPosition().searchInsert(nums, target));
	}

}
