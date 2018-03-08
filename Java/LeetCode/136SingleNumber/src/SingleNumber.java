
public class SingleNumber {
	public int singleNumber(int[] nums){
		for (int i = 1; i < nums.length; i++)
			nums[0] ^= nums[i];
		return nums[0];
	}
	
	public static void main(String args[]) {
		int[] nums = {2,5,3,2,15,9,5,3,9};
		System.out.print(new SingleNumber().singleNumber(nums));
	}

}
