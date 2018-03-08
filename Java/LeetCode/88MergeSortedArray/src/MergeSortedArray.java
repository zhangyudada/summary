
public class MergeSortedArray {
	public void merge(int[] nums1, int m, int[] nums2, int n) {
		m = m - 1;
		n = n - 1;
		int k = m + n + 1;
		while (m >= 0 && n >= 0) {
			if (nums1[m] > nums2[n])
				nums1[k--] = nums1[m--];
			else
				nums1[k--] = nums2[n--];
		}
		while (n >= 0)
			nums1[k--] = nums2[n--];
	}

	public static void main(String args[]) {
		int[] nums1 = {7,9,11,13,15,17};
		int m = 3;
		int[] nums2 = {10,12,14};
		int n =2;
		new MergeSortedArray().merge(nums1, m, nums2, n);
		for (int i = 0; i < nums1.length; i++)
			System.out.print(nums1[i]+" ");
	}
}
