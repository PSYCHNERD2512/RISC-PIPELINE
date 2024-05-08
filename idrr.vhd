LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.NUMERIC_STD.ALL;
ENTITY idrr IS
	PORT (
		clk, reset : IN STD_LOGIC;
		counter : INOUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		rf_a1, rf_a2, rf_a3 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		inst, pc : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		inst_out, pc_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		comp, c, z, load, jb : OUT STD_LOGIC;
		imm : OUT STD_LOGIC_VECTOR(8 DOWNTO 0));
END ENTITY;

ARCHITECTURE struct OF idrr IS
	SIGNAL i, p : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
	SIGNAL op, newop : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL ra3, ra2, ra1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL rfa1, rfa2, rfa3 : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN

	clk_proc : PROCESS (clk, counter, reset)
	BEGIN
		IF (clk'event AND clk = '1') THEN
			IF (counter = "000") THEN
				IF (reset = '0') THEN
					i <= inst;
					p <= pc;
					rfa1 <= i(11 DOWNTO 9);
					rfa2 <= i(8 DOWNTO 6);
					rfa3 <= i(5 DOWNTO 3);
					comp <= i(2);
					c <= i(1);
					z <= i(0);
					ra1 <= p(11 DOWNTO 9);
					ra2 <= p(8 DOWNTO 6);
					ra3 <= p(5 DOWNTO 3);
					op <= i(15 DOWNTO 12);
					newop <= p(15 DOWNTO 12);
					IF (op = "0100" OR op = "0101") THEN
						IF (newop = "0001" OR newop = "0010") THEN
							IF (ra1 = rfa1 OR ra1 = rfa2 OR ra2 = rfa1 OR ra2 = rfa2 OR ra3 = rfa1 OR ra3 = rfa2) THEN
								load <= '1';
								counter <= "001";
								jb <= '0';
								imm(5 DOWNTO 0) <= i(5 DOWNTO 0);
								imm(8 DOWNTO 6) <= "000";
							ELSE
								load <= '1';
								jb <= '0';
								imm(5 DOWNTO 0) <= i(5 DOWNTO 0);
								imm(8 DOWNTO 6) <= "000";
							END IF;
						ELSIF (newop = "0000") THEN
							IF (ra1 = rfa1 OR ra2 = rfa1 OR ra1 = rfa2 OR ra2 = rfa2) THEN
								imm(5 DOWNTO 0) <= i(5 DOWNTO 0);
								imm(8 DOWNTO 6) <= "000";
								jb <= '0';
								load <= '1';
								counter <= "001";
							ELSE
								imm(5 DOWNTO 0) <= i(5 DOWNTO 0);
								imm(8 DOWNTO 6) <= "000";
								jb <= '0';
								load <= '1';
							END IF;
						ELSE
							jb <= '0';
							load <= '1';
							imm(5 DOWNTO 0) <= i(5 DOWNTO 0);
							imm(8 DOWNTO 6) <= "000";
						END IF;
					ELSIF (op = "0011") THEN
						IF (newop = "0001" OR newop = "0010") THEN
							IF (ra1 = rfa1 OR ra2 = rfa1 OR ra3 = rfa1) THEN
								load <= '1';
								counter <= "001";
								imm(8 DOWNTO 0) <= i(8 DOWNTO 0);
								jb <= '0';
							ELSE
								load <= '1';
								jb <= '0';
								imm(8 DOWNTO 0) <= i(8 DOWNTO 0);
							END IF;
						ELSIF (newop = "0000") THEN
							IF (ra1 = rfa1 OR ra2 = rfa1) THEN
								imm(8 DOWNTO 0) <= i(8 DOWNTO 0);
								jb <= '0';
								load <= '1';
								counter <= "001";
							ELSE
								imm(8 DOWNTO 0) <= i(8 DOWNTO 0);
								jb <= '0';
								load <= '1';
							END IF;
						ELSE
							jb <= '0';
							load <= '1';
							imm(8 DOWNTO 0) <= i(8 DOWNTO 0);
						END IF;
					ELSIF (op = "0110" OR op = "0111") THEN
						load <= '0';
						jb <= '0';
						counter <= "110";
					ELSIF (op = "1001" OR op = "1000" OR op = "1010") THEN
						imm(5 DOWNTO 0) <= i(5 DOWNTO 0);
						imm(8 DOWNTO 6) <= "000";
						counter <= "011";
						load <= '0';
						jb <= '1';
					ELSIF (op = "1100" OR op = "1111" OR op = "1101") THEN
						imm(8 DOWNTO 0) <= i(8 DOWNTO 0);
						counter <= "011";
						load <= '0';
						jb <= '1';
					ELSE
						load <= '0';
						jb <= '0';
					END IF;
				ELSE
					i <= "0000000000000000";
					load <= '0';
					jb <= '0';
				END IF;
			ELSE
				counter <= STD_LOGIC_VECTOR(to_unsigned((to_integer(unsigned(counter))) - 1, 3));
			END IF;
		ELSE
		END IF;
	END PROCESS;
	rf_a1 <= rfa1;
	rf_a2 <= rfa2;
	rf_a3 <= rfa3;
	inst_out <= i;
	pc_out <= p;

END struct;
