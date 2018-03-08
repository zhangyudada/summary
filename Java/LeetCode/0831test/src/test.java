

import java.util.Scanner;

public class test {
    static int a[] = new int[100010];
    static long dp[] = new long[100010];

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n,k,i,j;  
        n = scanner.nextInt();
		int[] num;
		num=new int[n];
		for(i=0;i<n;i++){
            num[i]=(int)scanner.nextInt();
		}
		k = scanner.nextInt();
        long res,rtn;  
        while(true)  
        {  
            dp[0]=0;  
            res=0;
            rtn = 0;
            for(i=1;i<=n;i++)  
                dp[i]=dp[i-1]+num[i-1];  
            for(i=1;i<=n;i++)  
            {  
                for(j=0;j<=n-i;j++)  
                {  
                    if((dp[j+i]-dp[j])%k==0)
					{
                        res++;  
						rtn = i;
					}
                }  
            }  
            //System.out.println(res); 
			System.out.println(rtn);
			break;
        }  
    }
}