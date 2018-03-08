import java.util.HashMap;


//¶Ô±È#167
public class TwoSum {
	public int[] twoSum(int[] nums, int target) {
		/*//solution 1
		int[] rtn = new int[2];
		if (nums == null || nums.length < 2) return rtn;
        int length = nums.length;
		for (int i = 0; i < length; i++)
			for (int j = i+1; j < length; j++) {
				if (nums[i]+nums[j]==target) {
					rtn[0] = i;
					rtn[1] = j;
					return rtn;
				}
			}
		return rtn;*/
		
		//solution 2
		int[] rtn = new int[2];
		if (nums == null || nums.length < 2) return rtn;
		HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
		for (int i = 0; i < nums.length; i++) {
			if (map.containsKey(target - nums[i])) {
				rtn[0] = map.get(target - nums[i]);
				rtn[1] = i;
				return rtn;
			}
			map.put(nums[i], i);
		}
		return rtn;
	}
	
	public static void main(String args[]) {
		int[] numbers = {7,11,2,15};
		int target = 21;
		for (int i = 0; i < 2; i++)
			System.out.print(new TwoSum().twoSum(numbers, target)[i]+" ");
	}

}
