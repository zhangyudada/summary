//import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;


public class ContainsDuplicate {
	public boolean containsDuplicate(int[] nums) {
		/*//����������Լ���ģ�ͬ������۵ķ���2
		Arrays.sort(nums);
		for (int i = 1; i < nums.length; i++)
			if (nums[i] == nums[i-1]) return true;
		return false;*/
		
		//��������ο�������۷���3�����ߵ�3������
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
