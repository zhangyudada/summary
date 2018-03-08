
public class RotateArray {
	public void rotate(int[] nums, int k) {
		/*//solution 1
		k = k % nums.length;
		if (k == 0) return;
		int[] tmp = new int[k];
		for (int i = 0; i < k; i++)
			tmp[i] = nums[i + nums.length - k];
		for (int i = nums.length - k - 1; i >= 0 ; i--) 
			nums[i+k] = nums[i];
		for (int i = 0; i < k; i++)
			nums[i] = tmp[i];*/
		
		//solution 2
		k = k % nums.length;
		if (k == 0) return;
		reverse(nums, 0, nums.length-1);
		reverse(nums, 0, k-1);
		reverse(nums, k, nums.length-1);
	}
	
	//solution 2
	public void reverse(int[] nums, int start, int end) {
		int tmp;
		while (start < end) {
			tmp = nums[start];
			nums[start++] = nums[end];
			nums[end--] = tmp;
		}
	}
	
	public static void main(String args[]) {
		int[] nums = {1,2,3,4,5,6,7};
		int k = 6; 
		new RotateArray().rotate(nums, k);
		for (int i = 0; i < nums.length; i++)
			System.out.print(nums[i]+" ");
	}

}
