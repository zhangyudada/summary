import java.util.ArrayList;
import java.util.List;


public class Solution {
	List<Integer> BSTList = new ArrayList<Integer>();
	
	public void inOrder(TreeNode root) {
		if (root != null) {
			inOrder(root.left);
			BSTList.add(root.val);
			inOrder(root.right);
		}
	}
	
	public int getMinimumDifference(TreeNode root) {
		int min = Integer.MAX_VALUE;
		inOrder(root);
		for(int i = 0; i < BSTList.size()-1; i++) {
			if (BSTList.get(i+1)-BSTList.get(i) < min)
				min = BSTList.get(i+1)-BSTList.get(i);
		}
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
		System.out.print(new Solution().getMinimumDifference(root));
	}

}
