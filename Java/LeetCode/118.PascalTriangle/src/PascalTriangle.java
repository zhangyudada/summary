import java.util.ArrayList;
import java.util.List;


public class PascalTriangle {
	public List<List<Integer>> generate(int numRows) {
		List<Integer> tmpList = new ArrayList<Integer>();
		List<List<Integer>> rtnList = new ArrayList<List<Integer>>();
		if (numRows <= 0) return rtnList;
		tmpList.add(1);
		rtnList.add(new ArrayList<Integer>(tmpList));
		if (numRows == 1)
			return rtnList;
		tmpList.add(1);
		rtnList.add(new ArrayList<Integer>(tmpList));
		if (numRows == 2)
			return rtnList;
		for (int i = 3; i < numRows+1; i++) {
			tmpList.clear();
			tmpList.add(1);
			for (int j = 0; j < i-2; j++)
				tmpList.add(rtnList.get(i-2).get(j) + rtnList.get(i-2).get(j+1));
			tmpList.add(1);
			rtnList.add(new ArrayList<Integer>(tmpList));
		}
		return rtnList;
	}
	
	public static void main(String args[]) {
		System.out.print(new PascalTriangle().generate(0));
	}

}
