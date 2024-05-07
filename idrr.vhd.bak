library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;
entity idrr is
   port(clk, reset: in std_logic; 
			counter: inout std_logic_vector(2 downto 0);
			rfa1, rfa2, rfa3: out std_logic_vector(2 downto 0);
			inst, pc: in std_logic_vector(15 downto 0);
			inst_out, pc_out: out std_logic_vector(15 downto 0);
			comp, c, z, load, jb: out std_logic;
			imm : out std_logic_vector(8 downto 0));
end entity;

architecture struct of idrr is	
	signal i, p: std_logic_vector(15 downto 0):="0000000000000000";
	signal op: std_logic_vector(3 downto 0);
	begin
	
	clk_proc: process(clk,counter, reset)
		begin
		if (clk'event and clk='1') then 
			if (counter="000") then
				if (reset='0') then
					i<=inst;
					p<=pc;
					rfa1<=i(11 downto 9);
					rfa2<=i(8 downto 6);
					rfa3<=i(5 downto 3);
					comp<=i(2);
					c<=i(1);
					z<=i(0);
					op<=i(15 downto 12);
					if (op="0100" or op="0101") then
						load<='1';
						counter<= "001";
						imm(5 downto 0)<=i(5 downto 0);
						imm(8 downto 6)<="000";
						jb<='0';
					elsif (op="0011") then
						load<='1';
						counter<= "001";
						imm(8 downto 0)<=i(8 downto 0);
						jb<='0';
					elsif (op="0110" or op="0111") then
						load<='0';
						jb<='0';
						counter<= "110";
					elsif (op="1001" or op="1000") then
						imm(5 downto 0)<=i(5 downto 0);
						imm(8 downto 6)<="000";
						counter<= "011";
						load<='0';
						jb<='1';
					elsif (op="1100" or op="1111" or op="1101") then
						imm(8 downto 0)<=i(8 downto 0);
						counter<="011";
						load<='0';
						jb<='1';
					else
						load<='0';
						jb<='0';
					end if;
				else
					load<='0';
					jb<='0';
				end if;
			else
				counter<= std_logic_vector(to_unsigned((to_integer(unsigned(counter))) - 1,3));
			end if;
		else
		end if;
	end process;
	
	inst_out<=i;
	pc_out<=p;
	
end struct;