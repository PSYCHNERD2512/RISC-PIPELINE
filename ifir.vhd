library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;
entity ifid is
   port(clk, reset: in std_logic; 
			counter: inout std_logic_vector(2 downto 0);
			inst, pc: in std_logic_vector(15 downto 0);
			inst_out, pc_out: out std_logic_vector(15 downto 0));
end entity;

architecture struct of ifid is	
	signal i, p: std_logic_vector(15 downto 0):="0000000000000000";
	begin
	
	clk_proc: process(clk,counter, reset)
		begin
		if (clk'event and clk='1') then
			if (counter="000") then
				if (reset='0') then
					i<=inst;
					p<=pc;
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