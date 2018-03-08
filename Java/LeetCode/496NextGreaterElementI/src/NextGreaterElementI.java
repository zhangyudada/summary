
public class NextGreaterElementI {
	public int[] nextGreaterElement(int[] findNums, int[] nums) {
		int[] rtnNums = new int[findNums.length];
		for(int i = 0; i < findNums.length; i++)
			rtnNums[i] = -1;
		for(int i = 0; i < findNums.length; i++)
			for(int j = 0; j < nums.length; j++)
				if(findNums[i] == nums[j]) {
					for(int k = j+1; k < nums.length; k++)
						if(nums[k] > findNums[i]) {
							rtnNums[i] = nums[k];
							break;
						}
					break;
				}
		return rtnNums;
	}
	
	public static void main(String args[]) {
		int[] findNums = {2,9,4};
		int[] nums = {6,9,10,4,8,2};
		for(int i = 0; i < new NextGreaterElementI().nextGreaterElement(findNums, nums).length; i++)
			System.out.print(new NextGreaterElementI().nextGreaterElement(findNums, nums)[i]+" ");
	}

}
