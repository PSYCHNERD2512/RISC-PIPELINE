library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
library work;
use work.all;

entity mux_3 is
 port (a, b: in std_logic_vector(15 downto 0);
       opcode: in std_logic_vector(3 downto 0);
       o: out std_logic_vector(15 downto 0));
end entity mux_3;

architecture arch of mux_3 is 
signal sel: std_logic;
begin 
 sel <= ((not opcode(3)) and opcode(2)) or ((not opcode(3)) and opcode(1) and opcode(0));
 o <= (sel and b) or ((not sel) and a);
end arch;