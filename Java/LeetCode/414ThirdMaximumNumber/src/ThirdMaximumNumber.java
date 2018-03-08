import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class ThirdMaximumNumber {
	public int thirdMax(int[] nums) {
		//solution 1
		Set<Integer> set = new HashSet<Integer>();
		for (int i = 0; i < nums.length; i++)
			set.add(nums[i]);
		Integer[] arr = new Integer[set.size()];
		set.toArray(arr);
		Arrays.sort(arr);
		if (arr.length < 3) return arr[arr.length-1];
		return arr[arr.length-3];
		
		/*//solution 2
		Integer max1 = null, max2 = null, max3 = null;
		for (Integer n : nums) {
			if (n.equals(max1) || n.equals(max2) || n.equals(max3)) continue;
			if (max1 == null || n > max1) {
				max3 = max2;
				max2 = max1;
				max1 = n;
			} else if (max2 == null || n > max2) {
				max3 = max2;
				max2 = n;
			} else if (max3 == null || n > max3)
				max3 = n;
		}
		return max3==null ? max1 : max3;*/
	}
	
	public static void main(String args[]) {
		int[] nums = {-2147483648,-2147483648,-2147483648,-2147483648,1,1,1};
		System.out.print(new ThirdMaximumNumber().thirdMax(nums));
	}

}
