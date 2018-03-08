import java.util.Arrays;

public class AssignCookies {
	public int findContentChildren(int[] g, int[] s) {
		/*//solution 1
		if (s == null || s.length == 0 || g == null || g.length == 0) return 0;
		int rtn = 0;
		for (int i = 0; i < s.length; i++) {
			int index = -1;
			int cmp = Integer.MAX_VALUE;
			for (int j = 0; j < g.length; j++)
				if (s[i] >= g[j])
					if (cmp >= (s[i]-g[j])) {
						cmp = s[i]-g[j];
						index = j;
					}
			if (index != -1) {
				rtn++;
				g[index] = Integer.MAX_VALUE;
			}
			if (rtn == g.length) break;
		}
		return rtn;*/
		
		//solution 2
		if (s == null || s.length == 0 || g == null || g.length == 0) return 0;
		Arrays.sort(g);
		Arrays.sort(s);
		int i = 0;
		for (int j = 0; i < g.length && j < s.length; j++)
			if (g[i] <= s[j]) i++;
		return i;
	}
	
	public static void main(String args[]) {
		int[] g = {9,7,8,10};
		int[] s = {8,5,7,6};
		System.out.print(new AssignCookies().findContentChildren(g, s));
	}

}
