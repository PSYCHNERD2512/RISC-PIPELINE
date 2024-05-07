LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY work;
USE work.ALL;

ENTITY mux_3 IS
      PORT (
            a, b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            opcode : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            o : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY mux_3;

ARCHITECTURE arch OF mux_3 IS
      SIGNAL sel : STD_LOGIC;
BEGIN
      sel <= ((NOT opcode(3)) AND opcode(2)) OR ((NOT opcode(3)) AND opcode(1) AND opcode(0));
      o <= (sel AND b) OR ((NOT sel) AND a);
END arch;