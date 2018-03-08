import java.util.ArrayList;
import java.util.HashSet;


public class IntersectionOfTwoArrays {
	public int[] intersection(int[] nums1, int[] nums2) {
		if (nums1 == null || nums2 == null) return null;
		HashSet<Integer> set = new HashSet<Integer>();
		ArrayList<Integer> list = new ArrayList<Integer>();
		for (int i = 0; i < nums1.length; i++) set.add(nums1[i]);
		for (int i = 0; i < nums2.length; i++)
			if (set.contains(nums2[i])) {
				set.remove(nums2[i]);
				list.add(nums2[i]);
			}
		int[] rtn = new int[list.size()];
		for (int i = 0; i < list.size(); i++) rtn[i] = list.get(i);
		return rtn;
	}
	
	public static void main(String args[]) {
		int[] nums1 = {1,3,5,2,3};
		int[] nums2 = {};
		int[] res = new IntersectionOfTwoArrays().intersection(nums1, nums2);
		for (int i = 0; i < res.length; i++)
			System.out.print(res[i]+" ");
	}

}
