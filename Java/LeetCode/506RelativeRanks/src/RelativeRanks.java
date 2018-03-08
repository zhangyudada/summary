
public class RelativeRanks {
	public String[] findRelativeRanks(int[] nums) {
		//solution 1
		String[] rtn = new String[nums.length];
		if (nums.length == 1) {
			rtn[0] = "Gold Medal";
			return rtn;
		}
		if (nums.length == 2) {
			if (nums[0] > nums[1]) {
				rtn[0] = "Gold Medal";
				rtn[1] = "Silver Medal";
			}
			else {
				rtn[1] = "Gold Medal";
				rtn[0] = "Silver Medal";
			}
			return rtn;
		}
		for (int i = 0; i < nums.length; i++) {
			int rank = 1;
			for (int j = 0; j < nums.length; j++) {
				if (nums[i] < nums[j])
					rank++;
			}
			if (rank == 1)
				rtn[i] = "Gold Medal";
			else if (rank == 2)
				rtn[i] = "Silver Medal";
			else if (rank == 3)
				rtn[i] = "Bronze Medal";
			else
				rtn[i] = String.valueOf(rank);
		}		
		return rtn;
		
		/*//solution 2
		Integer[] index = new Integer[nums.length];
		for (int i = 0; i < nums.length; i++)
			index[i] = i;
		Arrays.sort(index, (a, b) -> (nums[b] - nums[a]));
		String[] rtn = new String[nums.length];
		for (int i = 0; i < nums.length; i++) {
			if (i == 0)
				rtn[index[i]] = "Gold Medal";
			else if (i == 1)
				rtn[index[i]] = "Silver Medal";
			else if (i == 2)
				rtn[index[i]] = "Bronze Medal";
			else
				rtn[index[i]] = (i+1)+"";
		}
		return rtn;*/

	}
	
	public static void main(String args[]) {
		int[] nums = {10,3,8,9,4};
		for (int i = 0; i < nums.length; i++)
			System.out.print(new RelativeRanks().findRelativeRanks(nums)[i]+" ");
	}

}
