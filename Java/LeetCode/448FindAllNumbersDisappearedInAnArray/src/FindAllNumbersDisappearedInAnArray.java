import java.util.ArrayList;
import java.util.List;


public class FindAllNumbersDisappearedInAnArray {
	public List<Integer> findDisappearedNumbers(int[] nums) {
		List<Integer> numsList = new ArrayList<Integer>();
		for (int i = 0; i < nums.length; i++)
			if (nums[Math.abs(nums[i])-1] > 0)
				nums[Math.abs(nums[i])-1] = -nums[Math.abs(nums[i])-1];
		for (int i = 0; i < nums.length; i++)
			if (nums[i] > 0)
				numsList.add(i+1);
		return numsList;
	}
	
	public static void main(String args[]) {
		int[] nums = {4,3,2,7,8,2,3,1};
		System.out.print(new FindAllNumbersDisappearedInAnArray().findDisappearedNumbers(nums));
	}

}
