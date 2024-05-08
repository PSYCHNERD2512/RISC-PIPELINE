library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;
entity exmm is
   port(clk, reset: in std_logic; 
			wb: out std_logic;
			counter: inout std_logic_vector(2 downto 0);
			inst_op: out std_logic_vector(15 downto 0);
			inst, pc: in std_logic_vector(15 downto 0);
			alu_op: in std_logic_vector(15 downto 0);
			inst_out, pc_out: out std_logic_vector(15 downto 0));
end entity;

architecture struct of exmm is	
	signal i, p: std_logic_vector(15 downto 0):="0000000000000000";
	signal op, newop: std_logic_vector(3 downto 0);
	signal ra3, rb1, rb2, ra2: std_logic_vector(2 downto 0);
	begin
	
	clk_proc: process(clk,counter, reset)
		begin
		if (clk'event and clk='1') then 
			if (counter="000") then
				if (reset='0') then
					i<=inst;
					p<=pc;
					ra3<=i(5 downto 3);
					ra2<=i(8 downto 6);
					rb1<=i(11 downto 9);
					rb2<=i(8 downto 6);
					inst_op<=alu_op;
					op<=i(15 downto 12);
					newop<=p(15 downto 12);
					if(op="0001" or op="0010") then
						if(newop="0001" or newop="0010") then
							if(ra3=rb1 or ra3=rb2) then
								wb<='1';
							else
								wb<='0';
							end if;
						elsif (newop="0000") then
							if (ra3=rb1) then
								wb<='1';
							else
								wb<='0';
							end if;
						else
							wb<='0';
						end if;
					elsif(op="0000") then
						if(newop="0001" or newop="0010") then
							if(ra2=rb1 or ra2=rb2) then
								wb<='1';
							else
								wb<='0';
							end if;
						elsif(newop="0000") then
							if(ra2=rb1) then
								wb<='1';
							else
								wb<='0';
							end if;
						else
							wb<='0';
						end if;
					else
						wb<='0';
					end if;
				else
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
