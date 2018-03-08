
public class MissingNumber {
	public int missingNumber(int[] nums) {
		if (nums == null || nums.length == 0) return 0;
		int arrSum = 0, numSum = 0;
		for (int i = 0; i < nums.length; i++) {
			arrSum += nums[i];
			numSum += i+1;
		}
		return numSum-arrSum;
	}
	
	public static void main(String args[]) {
		int[] nums = {5,2,0,1,3};
		System.out.print(new MissingNumber().missingNumber(nums));
	}

}
