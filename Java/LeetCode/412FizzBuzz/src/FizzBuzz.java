import java.util.ArrayList;
import java.util.List;


public class FizzBuzz {
	public List<String> fizzBuzz(int n) {
		List<String> al = new ArrayList<String>(n);
		/*//solution 1
		for (int i = 1; i <= n; i++)
			if (i % 3 == 0 && i % 5 == 0 )
				al.add("FizzBuzz"); 
			else if (i % 3 == 0)
				al.add("Fizz");
			else if (i % 5 == 0)
				al.add("Buzz");
			else
				al.add(String.valueOf(i));*/
		
		//solution 2
		int fizz = 0, buzz = 0;
		for (int i = 1; i <= n; i++) {
			fizz++;
			buzz++;
			if (fizz == 3 && buzz == 5) {
				al.add("FizzBuzz"); 
				fizz = 0;
				buzz = 0;
			} else if (fizz == 3) {
				al.add("Fizz"); 
				fizz = 0;
			} else if (buzz == 5){
				al.add("Buzz"); 
				buzz = 0;
			} else
				al.add(String.valueOf(i)); 
		}
		
		return al;
	}
	
	public static void main(String args[]) {
		System.out.print(new FizzBuzz().fizzBuzz(15));
	}

}
