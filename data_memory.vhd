LIBRARY std;
USE std.standard.ALL;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY DataMemory IS
	PORT (
		clk, w_flag, r_flag : IN STD_LOGIC;
		address, data_w : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		data_r : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END DataMemory;

ARCHITECTURE arch OF DataMemory IS
	TYPE RAM_array IS ARRAY (4095 DOWNTO 0) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL RAM : RAM_array := (
		0 => "1001000000000001",
		1 => "1001001000000001",
		2 => "1100000001000001",
		3 => "1010011001000001",
		4 => "1010100001000000",
		5 => "1010000001000000",
		6 => "1010110001000000",
		7 => "1000000011111111",
		8 => "1000000000000000",
		9 => "1001001000000000",
		10 => "1001000000000001",
		11 => "1010001000000000",
		12 => "1101000001000000",
		13 => "0110000001111000",
		14 => "1010001010000000",
		15 => "0110000001010000",
		16 => "0001000001000010",
		17 => "1000000000000010",
		18 => "1001000000000010",
		19 => "1010000001000010",
		20 => "1011000001000010",
		21 => "1100000001000010",
		22 => "1101000000000001",
		23 => "1111000001000000",
		OTHERS => "0000000000000001");
	-- hardcoded the instructions to test our CPU

BEGIN
	PROCESS (w_flag, r_flag, data_w, address, clk)
	BEGIN
		IF (w_flag = '1') THEN
			IF (clk'event AND clk = '1') THEN
				RAM(conv_integer(address)) <= data_w;
			END IF;
		END IF;
		IF (r_flag = '1') THEN
			data_r <= RAM(conv_integer(address));
		END IF;
	END PROCESS;
END arch;