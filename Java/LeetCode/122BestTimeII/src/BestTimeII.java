
public class BestTimeII {
	public int maxProfit(int[] prices) {
		if (prices == null || prices.length <= 1) return 0;
		int profit = 0;
		for (int i = 1; i < prices.length; i++)
			profit += prices[i]-prices[i-1]>0 ? prices[i]-prices[i-1] : 0;
		return profit;
	}
	
	public static void main(String args[]) {
		int[] prices = {};
		System.out.print(new BestTimeII().maxProfit(prices));
	}

}
