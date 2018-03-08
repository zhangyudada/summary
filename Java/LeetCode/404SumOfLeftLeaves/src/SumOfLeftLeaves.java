
public class SumOfLeftLeaves {
	public int sumOfLeftLeaves(TreeNode root) {
		if (root == null) return 0;
		int rtn = 0;
		if (root.left != null) {
			if (root.left.left == null && root.left.right == null)
				rtn += root.left.val;
			else rtn += sumOfLeftLeaves(root.left);
		}
		rtn += sumOfLeftLeaves(root.right);
		return rtn;
	}
	
	public static void main(String args[]) {
		//构建一个二叉树
		/*          1
		 *     2         3
		 *        5
		 */
		TreeNode right5 = new TreeNode(5);
		TreeNode left2 = new TreeNode(2);
		left2.right = right5;
		TreeNode right3 = new TreeNode(3);
		TreeNode root = new TreeNode(1);
		root.left = left2;
		root.right = right3;
		System.out.print(new SumOfLeftLeaves().sumOfLeftLeaves(root));
	}

}
