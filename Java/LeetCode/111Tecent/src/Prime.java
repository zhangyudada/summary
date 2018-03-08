import java.util.Scanner;
public class Prime {
	public static void main(String[] args) {
		System.out.print("Please input a digit: ");
		
		int num = new Scanner(System.in).nextInt();
		int rtn = 0;
		
		for(int i = 2; i <= num; i++){
			boolean isPrime = true;
			for(int j = 2; j <= Math.sqrt(i); j++){
				if(i % j == 0){
					isPrime = false;
					break;
				}
			}
			
			if(isPrime){
				rtn ++;
			}
		}
		System.out.println(rtn/2);
	}
}
