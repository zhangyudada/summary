
public class MaximumDepthOfBinaryTree {
	public int maxDepth(TreeNode root) {
		return root==null ? 0 : 1+Math.max(maxDepth(root.left),maxDepth(root.right));
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
		System.out.print(new MaximumDepthOfBinaryTree().maxDepth(root));
	}

}
