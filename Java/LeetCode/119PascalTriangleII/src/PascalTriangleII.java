import java.util.ArrayList;
import java.util.List;


public class PascalTriangleII {
	public List<Integer> getRow(int rowIndex) {
		List<Integer> list = new ArrayList<Integer>();
		if (rowIndex < 0) return list;
		list.add(1);
		if (rowIndex == 0) return list;
		list.add(1);
		if (rowIndex == 1) return list;
		if (rowIndex > 1) {
			list.clear();
			list.add(1);
			List<Integer> tmp = getRow(--rowIndex);
			for (int i = 0; i < tmp.size()-1; i++)
				list.add(tmp.get(i) + tmp.get(i+1));
			list.add(1);
		}
		return list;
			
	}
	
	public static void main(String args[]) {
		System.out.print(new PascalTriangleII().getRow(6));
	}
}
