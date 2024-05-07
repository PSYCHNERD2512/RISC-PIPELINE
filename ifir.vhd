LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.NUMERIC_STD.ALL;
ENTITY ifid IS
	PORT (
		clk, reset : IN STD_LOGIC;
		counter : INOUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		inst, pc : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		inst_out, pc_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY;

ARCHITECTURE struct OF ifid IS
	SIGNAL i, p : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
BEGIN

	clk_proc : PROCESS (clk, counter, reset)
	BEGIN
		IF (clk'event AND clk = '1') THEN
			IF (counter = "000") THEN
				IF (reset = '0') THEN
					i <= inst;
					p <= pc;
				ELSE
				END IF;
			ELSE
				counter <= STD_LOGIC_VECTOR(to_unsigned((to_integer(unsigned(counter))) - 1, 3));
			END IF;
		ELSE
		END IF;
	END PROCESS;

	inst_out <= i;
	pc_out <= p;

END struct;