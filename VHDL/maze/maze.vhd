library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity maze is
	port(
		clk: in std_logic;          --PIN18
		start,reset: in std_logic;  --BTN7,BTN6
		u,d,l,r: in std_logic;      --��������,BTN3~BTN0
		--switch:in std_logic;        --����ѡ���ͼ,SW0
		--beep:out std_logic;			--������
        dzshow: out std_logic_vector(23 downto 0); --row7~row0,colr7~colr0,colg7~colg0
												   --������ʾ 
		smgstate: out std_logic_vector(5 downto 0);  --cat5~cat0,�����״̬
		smgshow: out std_logic_vector(7 downto 0)    --abcdefgp,�������ʾ
		);
end maze;

architecture main of maze is
	signal cnt1: integer range 0 to 24999;    --���ڷ�Ƶ
	signal cnt2: integer range 0 to 24999999; --���ڷ�Ƶ  
	signal cnt3: integer range 0 to 4999999;  --���ڷ�Ƶ
	
	signal clk_time: std_logic;  --��ʱ��ʱ��,T1=0.01s
	signal clk_dz: std_logic;    --����ʱ��,T2=1s
	signal clk_key: std_logic;   --���������ж�ʱ��,T3=0.2s
	
	signal row: std_logic_vector(7 downto 0);  --������ʾ�̵�
	signal col: std_logic_vector(15 downto 0); --������ʾ�̵�
	
	signal tostart: std_logic;--ϵͳ�Ƿ�ʼ�������ź�	
	signal lgreset: std_logic; --�߼��ж�ģ������
	signal dzreset: std_logic; --����ģ������
	signal smgreset: std_logic; --�����ģ������
	signal treset: std_logic; --��ʱ��ģ������
	
	signal lgwork: std_logic; --�߼��ж�ģ�鹤��
	signal dzwork: std_logic; --������
	signal smgwork: std_logic; --����ܹ���
	signal twork: std_logic; --��ʱ������
	signal worked: std_logic;--ϵͳ�Ƿ��Ѿ������ı��
    
	signal vic: std_logic;--�ɹ�
	signal fal: std_logic;--ʧ��

	type smgst is array(0 to 9)of std_logic_vector(7 downto 0); 
	 
	signal smgshowed: smgst;--��������������ʾ����
	
	shared variable tend: integer range 0 to 1;
	shared variable ashan:integer range 0 to 9; 
	shared variable smgscan:integer range 0 to 3; --�����ɨ��
	shared variable aashan:integer range 0 to 7; 
	shared variable aa1shan:integer range 0 to 3; 
	shared variable a1shan:integer range 0 to 9; 
	shared variable x:integer range 0 to 7; --�̵������
	shared variable y:integer range 0 to 7; --�̵�������
	shared variable tz:integer range -1 to 30;--�ܵ���ʱ
	shared variable ts:integer range 0 to 3;--����ʱ����ʮλ 
	shared variable tg:integer range 0 to 9;--����ʱ������λ 
	shared variable tm:integer range 0 to 1000;--����ʱ�ڲ�����,1ms
	shared variable stepz: integer range 0 to 99;--���ƶ�����
	shared variable steps: integer range 0 to 9;--�ƶ�������ʮλ
	shared variable stepg: integer range 0 to 9;--�ƶ������ĸ�λ

begin
	smgshowed(0)<="11111100"; --0
	smgshowed(1)<="01100000"; --1
	smgshowed(2)<="11011010"; --2
	smgshowed(3)<="11110010"; --3
	smgshowed(4)<="01100110"; --4
	smgshowed(5)<="10110110"; --5
	smgshowed(6)<="10111110"; --6
	smgshowed(7)<="11100000"; --7
	smgshowed(8)<="11111110"; --8
	smgshowed(9)<="11110110"; --9
	
	timediv:process(clk)        --��ʱ����Ƶ
	begin
		if(clk'event and clk='1') then
			if(cnt1=24999) then
				cnt1<=0;
				clk_time<=not clk_time;--5e4��Ƶ,1000Hz,T1=1ms
			else
				cnt1<=cnt1+1;
			end if;
		end if;
	end process;

	dzdiv:process(clk)		--�����Ƶ
	begin
		if(clk'event and clk='1') then
			if(cnt2=24999999) then
				cnt2<=0;
				clk_dz<=not clk_dz;--5e7��Ƶ,1Hz,T2=1s
			else
				cnt2<=cnt2+1;
			end if;
		end if;
	end process;

	keydiv:process(clk)		--���������жϷ�Ƶ
	begin
		if(clk'event and clk='1') then
			if(cnt3=4999999) then
				cnt3<=0;
				clk_key<=not clk_key;--1e7��Ƶ,5Hz,T3=0.2s
			else
				cnt3<=cnt3+1;
			end if;
		end if;
	end process;

	control:process(clk,start,reset) --������
	begin
		if(clk'event and clk='1') then
			if(start='1') then
				tostart<='1';
			end if;
			if(reset='1' or tend=1) then 
				lgreset<='1';
				dzreset<='1';
				smgreset<='1';
				treset<='1';
				tostart<='0';
				dzwork<='0';
			else
				lgreset<='0';
				dzreset<='0';
				smgreset<='0';
				treset<='0';
				if(tostart='1') then 
					dzwork<='1'; --��������ģ��
				end if;
			end if;
		end if;
	end process;

	dz:process(clk_dz,dzreset) --������ģ��
	begin
		if(dzreset='1') then
			aa1shan:=0;
		else
			if(clk_dz'event and clk_dz='1') then
				if(vic='1' or fal='1') then	--������V������ʾ2s
					if(aa1shan<=2) then
						aa1shan:=aa1shan+1;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	process(clk_time,dzreset)
	begin
		if(dzreset='1') then
			a1shan:=0;
		else
			if(clk_time'event and clk_time='1') then
				if(a1shan=9) then
					a1shan:=0;
				else
					a1shan:=a1shan+1;
				end if;
			end if;
		end if;
	end process;
	
	process(clk_dz,dzreset,dzwork,worked)
	begin
		if(dzreset='1') then
			aashan:=0;
		else
			if(clk_dz'event and clk_dz='1' and dzwork='1' and worked='0') then
				if(aashan=7) then
					aashan:=0;
				else
					aashan:=aashan+1;
				end if;
			end if;
		end if;
	end process;
	
	process(clk_time,dzreset)
	begin
		if(dzreset='1') then
			ashan:=0;
		else
			if(clk_time'event and clk_time='1') then
				if(ashan=9) then
					ashan:=0;
				else
					ashan:=ashan+1;
				end if;
			end if;
		end if;
	end process;
	
	process(clk,dzreset,dzwork)
	begin
		if(dzreset='1') then
			dzshow<="000000000000000000000000";
			tend:=0;
			worked<='0';
			twork<='0';
			lgwork<='0';
		else
			if(clk'event and clk='1') then
				if(dzwork='1') then
					if(worked='0') then
						case aashan is
							when 0=>   --��ʾ����GO
								case ashan is
									when 1=>dzshow<="111111111111111100000000";
									when 0=>dzshow<="101111111111011100000000";
									when 2=>dzshow<="110111111000010100000000";
									when 3=>dzshow<="111011111000010100000000";
									when 4=>dzshow<="111101111011010100000000";
									when 5=>dzshow<="111110111001010100000000";
									when 6=>dzshow<="111111011111011100000000";
									when 7=>dzshow<="111111111111111100000000";
									when 9=>dzshow<="111111111111111100000000";
									when 8=>dzshow<="111111111111111100000000";
								end case;
							when 1=>   --��ʾ����GO
								case ashan is
									when 1=>dzshow<="111111111111111100000000";
									when 0=>dzshow<="101111111111011100000000";
									when 2=>dzshow<="110111111000010100000000";
									when 3=>dzshow<="111011111000010100000000";
									when 4=>dzshow<="111101111011010100000000";
									when 5=>dzshow<="111110111001010100000000";
									when 6=>dzshow<="111111011111011100000000";
									when 7=>dzshow<="111111111111111100000000";
									when 8=>dzshow<="111111111111111100000000";
									when 9=>dzshow<="111111111111111100000000";
								end case;
							when 2=>   --��ʾ����5
								case ashan is
									when 1=>dzshow<="011111110011110000000000";
									when 0=>dzshow<="101111110010000000000000";
									when 2=>dzshow<="110111110010000000000000";
									when 3=>dzshow<="111011110011110000000000";
									when 4=>dzshow<="111101110000010000000000";
									when 5=>dzshow<="111110110000010000000000";
									when 6=>dzshow<="111111010000010000000000";
									when 7=>dzshow<="111111100011110000000000";
									when 8=>dzshow<="111111111111111100000000";
									when 9=>dzshow<="111111111111111100000000";
								end case;
							when 3=>   --��ʾ����4
								case ashan is
									when 1=>dzshow<="011111110010010000000000";
									when 0=>dzshow<="101111110010010000000000";
									when 2=>dzshow<="110111110010010000000000";
									when 3=>dzshow<="111011110011110000000000";
									when 4=>dzshow<="111101110000010000000000";
									when 5=>dzshow<="111110110000010000000000";
									when 6=>dzshow<="111111010000010000000000";
									when 7=>dzshow<="111111100000010000000000";
									when 8=>dzshow<="111111111111111100000000";
									when 9=>dzshow<="111111111111111100000000";
								end case;
							when 4=>   --��ʾ����3
								case ashan is
									when 1=>dzshow<="011111110011110000000000";
									when 0=>dzshow<="101111110000010000000000";
									when 2=>dzshow<="110111110000010000000000";
									when 3=>dzshow<="111011110011110000000000";
									when 4=>dzshow<="111101110000010000000000";
									when 5=>dzshow<="111110110000010000000000";
									when 6=>dzshow<="111111010000010000000000";
									when 7=>dzshow<="111111100011110000000000";
									when 8=>dzshow<="111111111111111100000000";
									when 9=>dzshow<="111111111111111100000000";
								end case;
							when 5=>   --��ʾ����2
								case ashan is
									when 1=>dzshow<="011111110011110000000000";
									when 0=>dzshow<="101111110000010000000000";
									when 2=>dzshow<="110111110000010000000000";
									when 3=>dzshow<="111011110011110000000000";
									when 4=>dzshow<="111101110010000000000000";
									when 5=>dzshow<="111110110010000000000000";
									when 6=>dzshow<="111111010010000000000000";
									when 7=>dzshow<="111111100011110000000000";
									when 8=>dzshow<="111111111111111100000000";
									when 9=>dzshow<="111111111111111100000000";
								end case;
							when 6=>   --��ʾ����1
								case ashan is
									when 1=>dzshow<="011111110000100000000000";
									when 0=>dzshow<="101111110000100000000000";
									when 2=>dzshow<="110111110000100000000000";
									when 3=>dzshow<="111011110000100000000000";
									when 4=>dzshow<="111101110000100000000000";
									when 5=>dzshow<="111110110000100000000000";
									when 6=>dzshow<="111111010000100000000000";
									when 7=>dzshow<="111111100000100000000000";
									when 8=>dzshow<="111111111111111100000000";
									when 9=>dzshow<="111111111111111100000000";
								end case;
							when 7=>
								worked<='1';
								lgwork<='1';
								smgwork<='1';
								twork<='1';
								if (reset='1') then
									lgwork<='0';
									smgwork<='0';
									twork<='0';
								end if;
						end case;
					else
						if(fal='1') then
							twork<='0';
							lgwork<='0';
							if(aa1shan<=2) then   --��ʾ��ɫ��
								case a1shan is
									when 1=>dzshow<="011111111000000100000000";
									when 0=>dzshow<="101111110100001000000000";
									when 2=>dzshow<="110111110010010000000000";
									when 3=>dzshow<="111011110001100000000000";
									when 4=>dzshow<="111101110001100000000000";
									when 5=>dzshow<="111110110010010000000000";
									when 6=>dzshow<="111111010100001000000000";
									when 7=>dzshow<="111111101000000100000000";
									when 8=>dzshow<="111111111111111100000000";
									when 9=>dzshow<="111111111111111100000000";
								end case;
							else
								tend:=1;
							end if;
						elsif(vic='1') then   --��ʾ��ɫV
							twork<='0';
							lgwork<='0';
							if(aa1shan<=2) then
								case a1shan is
									when 1=>dzshow<="011111110000000000000000";
									when 0=>dzshow<="101111111000000100000000";
									when 2=>dzshow<="110111111000000100000000";
									when 3=>dzshow<="111011111000000100000000";
									when 4=>dzshow<="111101110100001000000000";
									when 5=>dzshow<="111110110010010000000000";
									when 6=>dzshow<="111111010001100000000000";
									when 7=>dzshow<="111111111111111100000000";
									when 8=>dzshow<="111111111111111100000000";
									when 9=>dzshow<="111111111111111100000000";
								end case;
							else
								tend:=1;
							end if;
						else
							case a1shan is   --��ʾ��ɫ�Թ�
								when 1=>dzshow<="011111111111111100000000";
								when 0=>dzshow<="101111110001110000000000";
								when 2=>dzshow<="110111111100010100000000";
								when 3=>dzshow<="111011110101010100000000";
								when 4=>dzshow<="111101110101010100000000";
								when 5=>dzshow<="111110110101110100000000";
								when 6=>dzshow<="111111010100000100000000";
								when 7=>dzshow<="111111100111111100000000";
								when 8=>dzshow<="111111111111111100000000";
								when 9=>   --�̵���ʾ(x,y)
									case x is
										when 0=>col<="0000000010000000";
										when 1=>col<="0000000001000000";										
										when 2=>col<="0000000000100000";
										when 3=>col<="0000000000010000";
										when 4=>col<="0000000000001000";
										when 5=>col<="0000000000000100";
										when 6=>col<="0000000000000010";
										when 7=>col<="0000000000000001";
									end case;
									case y is
										when 0=>row<="11111110";
										when 1=>row<="11111101";
										when 2=>row<="11111011";
										when 3=>row<="11110111";
										when 4=>row<="11101111";
										when 5=>row<="11011111";
										when 6=>row<="10111111";
										when 7=>row<="01111111";
									end case;
								dzshow<=row&col;
							end case;
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	t:process(clk,clk_time,treset,twork)    --��ʱ��ģ��
	begin
		if(treset='1')then
			tz:=30;
			ts:=0;
			tg:=0;
			tm:=0;
		else
			if(twork='1')then
				if(clk_time'event and clk_time='1') then
					tm:=tm+1;
					if(tm>=1000) then
						tm:=0;
						tz:=tz-1;
					end if;
					if(tz<=0) then
						tz:=0;
					end if;
					ts:=tz/10;
					tg:=tz-10*ts;					
				end if;
			end if;
		end if;
	end process;
	
	lg:process(clk_key,lgreset,lgwork,u,d,l,r)    --�߼��ж�ģ��
		variable derx :integer range -1 to 1;
		variable dery :integer range -1 to 1;
	begin
		if(lgreset='1') then
			x:=7;
			y:=6;--�̵��ʼλ��
			stepz:=0;--�ƶ�����Ϊ0
			steps:=0;
			stepg:=0;
			vic<='0';
			fal<='0';
		else
			if(lgwork='1') then
				if(clk_key'event and clk_key='1') then
					derx:=0;
					dery:=0;
					if(tz>0) then
						if(l='1')then
							derx:=-1;
						elsif(r='1') then
							derx:=1;
						elsif(u='1')then
							dery:=1;
						elsif(d='1')then
							dery:=-1;
						else
						end if;						
						x:=x+derx;
						y:=y+dery;--���갴������¸�λ��
						if( (x=7 and y=6)or
							(x=6 and y>=1 and y<=6)or 
							(x>=2 and x<=5 and y=1)or 
							(x=2 and y>=2 and y<=6)or 
							(x>=0 and x<=1 and y=6)or
							(x=3 and y=5)or
							(x=4 and y>=3 and y<=5)) then--����¸�λ����������
							stepz:=stepz+1;	--������1���̵��ƶ�����һ��λ��
							steps:=stepz/10;
							stepg:=stepz-10*steps;
							if(x=0 and y=6) then	--�����յ�
								vic<='1';
							else	--�¸�λ�ò���������
								x:=x-derx;
								y:=y-dery;--�̵㱣��ԭ����λ��
							end if;
						end if;
					else
						fal<='1';
					end if;
				end if;
			end if;
		end if;
	end process;
	


	smg:process(clk_time)    --�������ʾģ��
	begin
		if(clk_time'event and clk_time='1') then
			if(smgscan=3) then
				smgscan:=0;
			else
				smgscan:=smgscan+1;
			end if;
		end if;
	end process;
	
	process(clk_time,smgreset,smgwork)
	begin
		if(smgreset='1') then   --�������
			smgstate<="111111";
			smgshow<="00000000";
		else
			if(clk_time'event and clk_time='1') then
				if(smgwork='1') then
					case smgscan is
						when 0=>   	--�����cat0��ʾ����ʱ������λ
							smgstate<="111110";
							smgshow<=smgshowed(tg);
						when 1=>   	--�����cat1��ʾ����ʱ����ʮλ
							smgstate<="111101";
							smgshow<=smgshowed(ts);
						when 2=>	--�����cat4��ʾ�ƶ�������λ
							smgstate<="101111";
							smgshow<=smgshowed(stepg);
						when 3=>	--�����cat5��ʾ�ƶ�����ʮλ
							smgstate<="011111";
							smgshow<=smgshowed(steps);
					end case;
				else
					case smgscan is --����ܲ�����ʱ��λ��ʾ0
						when 0=>
							smgstate<="111110";
							smgshow<=smgshowed(0);
						when 1=>
							smgstate<="111101";
							smgshow<=smgshowed(0);
						when 2=>
							smgstate<="101111";
							smgshow<=smgshowed(0);
						when 3=>
							smgstate<="011111";
							smgshow<=smgshowed(0);
					end case;
				end if;
			end if;
		end if;
	end process;
end main;