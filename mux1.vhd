LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY work;
USE work.ALL;

ENTITY mux_1 IS
	PORT (
		a, b, c, d : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		opcode : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		o : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY mux_1;
ARCHITECTURE arch OF mux_1 IS
	SIGNAL sel : STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN
	sel(1) <= (opcode(3)) AND (opcode(2) OR opcode(1));
	sel(0) <= ((NOT opcode(3)) AND (opcode(2))) OR ((NOT opcode(3)) AND (NOT opcode(2)) AND (NOT opcode(1))) OR ((NOT opcode(3)) AND (opcode(2)) AND (opcode(1)));

	o <= (((NOT sel(1)) AND (NOT sel(0))) AND a) OR (((NOT sel(1)) AND (sel(0))) AND b) OR (((NOT sel(1)) AND (sel(0))) AND c) OR (((sel(1)) AND (sel(0))) AND d);
END arch;