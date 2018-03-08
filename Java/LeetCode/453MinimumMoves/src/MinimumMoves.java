
public class MinimumMoves {
	public int minMoves(int[] nums) {
		/*
		 * ���鳤��Ϊn��ԭ����Ԫ��֮��Ϊsum����������СԪ��Ϊmin
		 * ���շ���ֵ��rtn,����������rtn�Σ�ÿ������Ԫ���ܺ�����(n-1)
		 * ��������Ԫ��ȫΪa
		 * sum + rtn*(n-1) = a*n
		 * ��  a = min + rtn
		 * ��� rtn = sum - n*min
		 */
		if (nums.length == 1) return 0;
		if (nums.length == 2) return Math.abs(nums[0]-nums[1]);
		//int sum = nums[0];
		int min = nums[0], n = nums.length;
		/*for (int i = 0; i < n; i++) {
			sum += nums[i];
			if (min > nums[i]) min = nums[i];
		}
		return sum - n*min;*/
		for (int i = 1; i < n; i++)
			min = Math.min(min, nums[i]);
		int rtn = 0;
		for (int i = 0; i < n; i++)
			rtn += nums[i]-min;
		return rtn;
	}
	
	public static void main(String args[]) {
		int[] nums = {1,7,3};
		System.out.print(new MinimumMoves().minMoves(nums));
	}

}
