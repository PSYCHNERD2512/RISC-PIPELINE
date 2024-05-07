library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.all;

entity mux_1 is
    port (a,b,c,d: in std_logic_vector(15 downto 0);
			 opcode: in std_logic_vector(3 downto 0);
		  o: out std_logic_vector(15 downto 0));
end entity mux_1;


architecture arch of mux_1 is
signal sel: std_logic_vector(1 downto 0);
begin
sel(1) <= (opcode(3)) and (opcode(2) or opcode(1));
sel(0) <= ((not opcode(3)) and (opcode(2))) or ((not opcode(3)) and (not opcode(2)) and (not opcode(1))) or ((not opcode(3)) and (opcode(2)) and (opcode(1)));

o <= (((not sel(1)) and (not sel(0))) and a) or (((not sel(1)) and (sel(0))) and b) or (((not sel(1)) and (sel(0))) and c) or (((sel(1)) and (sel(0))) and d);
end arch;
