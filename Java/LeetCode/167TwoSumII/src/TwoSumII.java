
//¶Ô±È#1
public class TwoSumII {
	public int[] twoSum(int[] numbers, int target) {
		int[] rtn = new int[2];
		if (numbers == null || numbers.length < 2) return rtn;
		int left = 0, right = numbers.length-1;
		while (left < right) {
			int sum = numbers[left] + numbers[right];
			if (sum == target) {
				rtn[0] = left + 1;
				rtn[1] = right + 1;
				return rtn;
			}
			else if (sum < target)
				left++;
			else
				right--;
		}
		return null;
	}
	
	public static void main(String args[]) {
		int[] numbers = {2,7,11,15};
		int target = 22;
		for (int i = 0; i < 2; i++)
			System.out.print(new TwoSumII().twoSum(numbers, target)[i]+" ");
	}

}
