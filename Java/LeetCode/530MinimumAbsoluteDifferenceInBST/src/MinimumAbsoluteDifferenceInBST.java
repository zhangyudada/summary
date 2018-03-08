
public class MinimumAbsoluteDifferenceInBST {
	int min = Integer.MAX_VALUE;
	Integer prev = null;
	
	public int getMinimumDifference(TreeNode root) {
		/*
		//这个算法对[236,104,701,null,227,null,911]计算有错，该算法计算出123，实际为9
		if (root == null) return Integer.MAX_VALUE;
		if (root.left == null && root.right == null) return Integer.MAX_VALUE;
		int rtn1 = 0;
		int rtn2 = 0;
		if (root.left != null && root.right == null) {
			rtn1 = root.val-root.left.val;
			rtn2 = getMinimumDifference(root.left);
			return (rtn1 < rtn2) ? rtn1 : rtn2;
		}
		if (root.left == null && root.right != null) {
			rtn1 = root.right.val-root.val;
			rtn2 = getMinimumDifference(root.right);
			return (rtn1 < rtn2) ? rtn1 : rtn2;
		}
		if (root.left != null && root.right != null) {
			int tmp1 = root.val-root.left.val;
			int tmp2 = getMinimumDifference(root.left);
			rtn1 = tmp1<tmp2 ? tmp1 : tmp2;
			int tmp3 = root.right.val-root.val;
			int tmp4 = getMinimumDifference(root.right);
			rtn2 = tmp3<tmp4 ? tmp3 : tmp4;
			return (rtn1 < rtn2) ? rtn1 : rtn2;
		}		
		return 0;*/
		
		if (root == null) return 0;
		getMinimumDifference(root.left);
		if (prev != null)
			min = Math.min(min, root.val-prev);
		prev = root.val;
		getMinimumDifference(root.right);
		return min;
	}
	
	public static void main(String args[]) {
		/*//构建一个二叉搜索树(BST)
		          3
		 *     1         5
		 *        2
		 
		TreeNode right2 = new TreeNode(2);
		TreeNode left1 = new TreeNode(1);
		left1.right = right2;
		TreeNode right5 = new TreeNode(5);
		TreeNode root = new TreeNode(3);
		root.left = left1;
		root.right = right5;*/
		//构建一个二叉搜索树(BST)
		/*    1
		 *       3
		 *     2
		 */
		TreeNode right3 = new TreeNode(3);
		TreeNode left2 = new TreeNode(2);
		right3.left = left2;
		TreeNode root = new TreeNode(1);
		root.right = right3;
		System.out.print(new MinimumAbsoluteDifferenceInBST().getMinimumDifference(root));
	}

}
