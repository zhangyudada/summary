
public class MaximumSubarray {
	public int maxSubArray(int[] nums) {
		//KadaneËã·¨£¬²Î¿¼#121
		int e = nums[0], m = nums[0];
		for (int i = 1; i < nums.length; i++) {
			e = Math.max(nums[i], nums[i]+e);
			m = Math.max(e, m);
		}
		return m;
	}
	
	public static void main(String args[]) {
		int[] nums = {-2,1,-3,4,-1,2,1,-5,4};
		System.out.print(new MaximumSubarray().maxSubArray(nums));
	}

}
