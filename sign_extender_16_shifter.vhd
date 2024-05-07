LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SE6_shifter IS
	PORT (
		input : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY SE6_shifter;

ARCHITECTURE bhv OF SE6_shifter IS
	SIGNAL temp : STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
	extend : PROCESS (input, temp)
	BEGIN
		IF (input(5) = '0') THEN
			temp <= "0000000000" & input;
		ELSE
			temp <= "1111111111" & input;
		END IF;
		output <= temp(14 DOWNTO 0) & '0';
	END PROCESS;
END bhv;