LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SE6 IS
	PORT (
		input : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY SE6;

ARCHITECTURE bhv OF SE6 IS
BEGIN
	extend : PROCESS (input)
	BEGIN
		IF (input(5) = '0') THEN
			output <= "0000000000" & input;
		ELSE
			output <= "1111111111" & input;
		END IF;
	END PROCESS;
END bhv;