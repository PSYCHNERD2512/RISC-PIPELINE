LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY work;
USE work.ALL;

ENTITY mux_4 IS
    PORT (
        c, z : IN STD_LOGIC;
        a, b, c, d : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        opcode : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        o : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY mux_4;
ARCHITECTURE arch OF mux_4 IS
    SIGNAL sel : STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN
    sel(0) <= (opcode(3) AND opcode(2) AND (NOT opcode(1))) OR ((NOT c) AND (NOT z)) OR (NOT opcode(3)) OR (opcode(3) AND opcode(2) AND opcode(1));
    sel(1) <= (NOT opcode(3)) AND (opcode(3) AND (NOT opcode(2)) AND opcode(1) AND opcode(0)) OR (opcode(3) AND (NOT opcode(2)) AND (NOT opcode(1)) AND (NOT c) AND (NOT z)) OR (opcode(3) AND opcode(2) AND (NOT opcode(0)));

    o <= (((NOT sel(1)) AND (NOT sel(0))) AND a) OR (((NOT sel(1)) AND (sel(0))) AND b) OR (((NOT sel(1)) AND (sel(0))) AND c) OR (((sel(1)) AND (sel(0))) AND d);
END arch;