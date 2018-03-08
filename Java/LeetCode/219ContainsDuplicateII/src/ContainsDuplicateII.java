import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;




public class ContainsDuplicateII {
	public boolean containsNearbyDuplicate(int[] nums, int k) {
		/*//solution 1，自己想的
		Map<Integer,Integer> map = new HashMap<Integer,Integer>();
		for (int i = 0; i < nums.length; i++)
			if (map.containsKey(nums[i]) && Math.abs( map.get(nums[i]) - i ) <= k)
				return true;
			else map.put(nums[i], i);
		return false;*/
		
		//solution 2
		Set<Integer> set = new HashSet<Integer>();
		for (int i = 0; i < nums.length; i++) {
			if (i > k) set.remove(nums[i-k-1]);
			if (!set.add(nums[i])) return true;
		}
		return false;
	}
	
	public static void main(String args[]) {
		int[] nums = {1,3,5,6,2,9,8};
		int k = 5;
		System.out.print(new ContainsDuplicateII().containsNearbyDuplicate(nums, k));
	}

}
