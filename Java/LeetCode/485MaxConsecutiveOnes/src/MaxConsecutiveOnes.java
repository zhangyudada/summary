
public class MaxConsecutiveOnes {
	public int findMaxConsecutiveOnes(int[] nums) {
		int rtn = 0, count = 0;
		for (int i = 0; i < nums.length; i++) {
			if (nums[i] == 0 || i == nums.length-1) {
				if (i == nums.length-1 && nums[i] == 1) count++;
				if (rtn < count)
					rtn = count;
				count = 0;
				continue;
			}
			count++;	
		}
		return rtn;
	}
	
	public static void main(String args[]) {
		int[] nums = {1,1,0,0,1,1,0,1,0,0,1,1,1,0};
		System.out.print(new MaxConsecutiveOnes().findMaxConsecutiveOnes(nums));
	}

}
