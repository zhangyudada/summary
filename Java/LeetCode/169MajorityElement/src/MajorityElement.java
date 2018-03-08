/*import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;*/


public class MajorityElement {
	public int majorityElement(int[] nums) {
		/*//solution 1 - HashMap
		Map<Integer,Integer> map = new HashMap<Integer, Integer>();
		for (int i = 0; i < nums.length; i++)
			if (!map.containsKey(nums[i]))
				map.put(nums[i], 1);
			else
				map.put(nums[i], map.get(nums[i])+1);
		for (int i = 0; i < nums.length; i++)
			if (map.get(nums[i]) > nums.length/2)
				return nums[i];
		return 0;*/
		
		/*//solution 2
		Arrays.sort(nums);
		return nums[nums.length/2];*/
		
		//solution 3
		int major = nums[0], count = 1;
		for (int i = 1; i < nums.length; i++) {
			if (count == 0) {
				major = nums[i];
				count++;
			} else if (nums[i] == major) count++;
			else count--;
		}
		return major;
	}
	
	public static void main(String args[]) {
		int[] nums = {6,5,5};
		System.out.print(new MajorityElement().majorityElement(nums));
	}

}
