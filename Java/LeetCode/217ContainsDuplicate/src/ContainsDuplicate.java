//import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;


public class ContainsDuplicate {
	public boolean containsDuplicate(int[] nums) {
		/*//这个方法是自己想的，同最高评论的方法2
		Arrays.sort(nums);
		for (int i = 1; i < nums.length; i++)
			if (nums[i] == nums[i-1]) return true;
		return false;*/
		
		//这个方法参考最高评论方法3，或者第3高评论
		Set<Integer> set = new HashSet<Integer>();
		for (int i = 0; i < nums.length; i++)
			if (!set.add(nums[i])) return true;
		return false;
	}
	
	public static void main(String args[]) {
		int[] nums = {1,3,5};
		System.out.print(new ContainsDuplicate().containsDuplicate(nums));
	}

}
