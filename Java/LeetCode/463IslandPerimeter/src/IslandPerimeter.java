
public class IslandPerimeter {
	public int islandPerimeter(int[][] grid) {
		if (grid.length == 0 || grid[0].length == 0) return 0;
		int per = 0;
		for (int i = 0; i < grid.length; i++)
			for (int j = 0; j < grid[0].length; j++) {
				if (grid[i][j] == 0) continue;
				//up,down,left,right
				if (i == 0 || grid[i-1][j] == 0) ++per;
				if (i == grid.length-1 || grid[i+1][j] == 0) ++per;
				if (j == 0 || grid[i][j-1] == 0) ++per;
				if (j == grid[0].length-1 || grid[i][j+1] == 0) ++per;
			}
		return per;
	}
	
	public static void main(String args[]) {
		int[][] grid = {{0,1,0,0},{1,1,1,0},{0,1,0,0},{1,1,0,0}};
		System.out.print(new IslandPerimeter().islandPerimeter(grid));
	}

}
