
public class NimGame {
	public boolean canWinNim(int n) {
		//˭����ʣ��4����������ʯͷ�ͱ�������
		//�����ߣ�nΪ4�����������ұ��䣻�����ǣ����������ɸ�ʹ��ʣ��ʯͷ��Ϊ4�������������ұ�Ӯ
		return n % 4 != 0;
	}
	
	public static void main(String args[]) {
		System.out.print(new NimGame().canWinNim(3));
	}

}
