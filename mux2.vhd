LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY work;
USE work.ALL;

ENTITY mux_2 IS
      PORT (
            a, b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            opcode : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            o : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY mux_2;

ARCHITECTURE arch OF mux_2 IS
      SIGNAL sel : STD_LOGIC;
BEGIN
      sel <= opcode(2) OR (opcode(1) AND opcode(0)) OR (opcode(3) AND opcode(1));
      o <= (sel AND b) OR ((NOT sel) AND a);
END arch;