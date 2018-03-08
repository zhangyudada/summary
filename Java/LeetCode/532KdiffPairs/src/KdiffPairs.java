
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class KdiffPairs {
	public int findPairs(int[] nums, int k) {
		//本题难点在于k=0时的计算
		if(nums == null || nums.length  == 0 || nums.length  == 1 || k < 0) return 0;
		if (k == 0) {
			Arrays.sort(nums);
			int ele = nums[0],index = 0, cnt = 0;
			for (int i = 1; i < nums.length; i++)
				if (nums[i] != ele || i == nums.length-1) {
					if (nums[i] != ele && i-index > 1)
						cnt++;
					if (i == nums.length-1 && nums[i] == nums[i-1])
						cnt++;
					ele = nums[i];
					index = i;
				}
			return cnt;
		}
		Set<Integer> set = new HashSet<Integer>();
		for (Integer e : nums)
			set.add(e);
		int pairs = 0;
		for (Integer e : set)
			if (set.contains(e+k)) pairs++;
		return pairs;
	}
	
	public static void main(String args[]) {
		int[] nums = {1,2,3,4,5};
		int k = -1;
		System.out.print(new KdiffPairs().findPairs(nums, k));
	}

}
