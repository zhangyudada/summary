
public class BestTime {
	public int maxProfit(int[] prices) {
		/*//solution 1
		if (prices == null || prices.length  == 1) return 0;
		int max = 0;
		for (int i = 0; i < prices.length-1; i++)
			for (int j = i+1; j < prices.length; j++)
				max = max>(prices[j]-prices[i]) ? max : prices[j]-prices[i];
		return max;*/
		
		//solution 2
		//参考http://www.cnblogs.com/en-heng/p/3970231.html
		if (prices == null || prices.length <= 1) return 0;
		int[] diff = new int[prices.length-1];
		//构造数组prices两两元素之差的数组diff，则原问题转换为求diff数组最大子序列和的问题，可利用Kadane算法
		//sum(diff[i~j]) = prices[j+1]-prices[i]
		for (int i = 0; i < prices.length-1; i++)
			diff[i] = prices[i+1] - prices[i];
		//Kadane算法
		int e = diff[0], m = diff[0];
		for (int i = 1; i < diff.length; i++) {
			e = Math.max(diff[i], diff[i]+e);
			m = Math.max(m, e);
		}
		return m>0 ? m : 0;
	}
	
	public static void main(String args[]) {
		int[] prices = {};
		System.out.print(new BestTime().maxProfit(prices));
	}

}
