LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY work;
USE work.ALL;

ENTITY reg_file IS
	PORT (
		A1, A2, A3 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		D1, D2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		D3 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		clk, rf_write : IN STD_LOGIC);
END ENTITY reg_file;

ARCHITECTURE arch OF reg_file IS

	COMPONENT reg IS
		PORT (
			input : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			en, clk : IN STD_LOGIC;
			output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT reg;

	-- enable signals for respective register
	SIGNAL e0, e1, e2, e3, e4, e5, e6, e7 : STD_LOGIC;
	-- output signals for respective register
	SIGNAL r0, r1, r2, r3, r4, r5, r6, r7 : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN

	-- enable signals of the regsiters
	e0 <= rf_write AND (NOT(A3(2))) AND (NOT(A3(1))) AND (NOT(A3(0))); -- rf_write and address '000'
	e1 <= rf_write AND (NOT(A3(2))) AND (NOT(A3(1))) AND (A3(0)); -- rf_write and address '001'
	e2 <= rf_write AND (NOT(A3(2))) AND (A3(1)) AND (NOT(A3(0))); -- rf_write and address '010'
	e3 <= rf_write AND (NOT(A3(2))) AND (A3(1)) AND (A3(0)); -- rf_write and address '011'
	e4 <= rf_write AND (A3(2)) AND (NOT(A3(1))) AND (NOT(A3(0))); -- rf_write and address '100'
	e5 <= rf_write AND (A3(2)) AND (NOT(A3(1))) AND (A3(0)); -- rf_write and address '101'
	e6 <= rf_write AND (A3(2)) AND (A3(1)) AND (NOT(A3(0))); -- rf_write and address '110'
	e7 <= rf_write AND (A3(2)) AND (A3(1)) AND (A3(0)); -- rf_write and address '111'

	-- Initialise the registers
	reg0 : reg PORT MAP(input => D3, en => e0, clk => clk, output => r0);
	reg1 : reg PORT MAP(input => D3, en => e1, clk => clk, output => r1);
	reg2 : reg PORT MAP(input => D3, en => e2, clk => clk, output => r2);
	reg3 : reg PORT MAP(input => D3, en => e3, clk => clk, output => r3);
	reg4 : reg PORT MAP(input => D3, en => e4, clk => clk, output => r4);
	reg5 : reg PORT MAP(input => D3, en => e5, clk => clk, output => r5);
	reg6 : reg PORT MAP(input => D3, en => e6, clk => clk, output => r6);
	reg7 : reg PORT MAP(input => D3, en => e7, clk => clk, output => r7);

	WITH A1 SELECT
		D1 <= r0 WHEN "000",
		r1 WHEN "001",
		r2 WHEN "010",
		r3 WHEN "011",
		r4 WHEN "100",
		r5 WHEN "101",
		r6 WHEN "110",
		r7 WHEN "111",
		r0 WHEN OTHERS;

	WITH A2 SELECT
		D2 <= r0 WHEN "000",
		r1 WHEN "001",
		r2 WHEN "010",
		r3 WHEN "011",
		r4 WHEN "100",
		r5 WHEN "101",
		r6 WHEN "110",
		r7 WHEN "111",
		r0 WHEN OTHERS;
END arch;