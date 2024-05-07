LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY work;
USE work.ALL;

ENTITY pipeline_cpu IS
    PORT (
        i : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        clk : IN STD_LOGIC
    );
END ENTITY pipeline_cpu;
ARCHITECTURE arch OF pipeline_cpu IS

    COMPONENT idrr IS
        PORT (
            clk, reset : IN STD_LOGIC;
            counter : INOUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            rf_a1, rf_a2, rf_a3 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            inst, pc : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            inst_out, pc_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            comp, c, z, load, jb : OUT STD_LOGIC;
            imm : OUT STD_LOGIC_VECTOR(8 DOWNTO 0));
    END COMPONENT idrr;

    COMPONENT alu IS
        PORT (
            aluA, aluB : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            ctrl : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            c, z : IN STD_LOGIC;
            aluC : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            cOut, zOut : OUT STD_LOGIC
        );
    END COMPONENT alu;

    COMPONENT mux_1 IS
        PORT (
            a, b, c, d : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            opcode : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            o : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT mux_1;

    COMPONENT mux_2 IS
        PORT (
            a, b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            opcode : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            o : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT mux_2;

    COMPONENT SE6 IS
        PORT (
            input : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT SE6;

    COMPONENT SE6_shifter IS
        PORT (
            input : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT SE6_shifter;

    COMPONENT rf IS
        PORT (
            A1, A2, A3 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            D1, D2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            D3 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            clk, rf_write : IN STD_LOGIC
        );
    END COMPONENT rf;

    COMPONENT mux_1 IS
        PORT (
            a, b, c, d : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            opcode : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            o : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT mux_1;

    SIGNAL D1_out, D2_out, aluC_out, D3_out : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL cOut, zOut : STD_LOGIC;
    SIGNAL alu_a_in, alu_b_in, SE6_out, SE6_shifter_out : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL count1, count2 : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
    SIGNAL rf_a1_i, rf_a2_i, rf_a3_i : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN

    mux_2inst : mux_2 PORT MAP(a => d1_out, b => d2_out, opcode => (OTHERS => '0'), o => alu_a_in);
    mux_1inst : mux_1 PORT MAP(a => d2_out, b => SE6_out, c => SE6_shifter_out, d => (OTHERS => '0'), o => alu_b_in, opcode => (OTHERS => '0'));

    SE6_init : SE6 PORT MAP(
        input => (OTHERS => '0'),
        output => SE6_out
    );
    SE6_shift_init : SE6_shifter PORT MAP(
        input => (OTHERS => '0'),
        output => SE6_shifter_out
    );
    idrr_init : idrr PORT MAP(
        clk => clk,
        reset => '0',
        counter => count1,
        rf_a1 => rf_a1_i,
        rf_a2 => rf_a2_i,
        rf_a3 => rf_a3_i,
        inst => (OTHERS => '0'),
        inst_out => (OTHERS => '0'),
        pc => (OTHERS => '0'),
        pc_out => (OTHERS => '0'),
        comp => '0',
        c => '0',
        z => '0',
        load => '0',
        jb => '0',
        imm => (OTHERS => '0')
    );

    RF_inst : rf PORT MAP(
        A1 => (OTHERS => '0'),
        A2 => (OTHERS => '0'),
        A3 => (OTHERS => '0'),
        D1 => D1_out,
        D2 => D2_out,
        D3 => (OTHERS => '0'),
        clk => clk,
        rf_write => '0'
    );
    ALU_inst : alu PORT MAP(
        aluA => alu_a_in,
        aluB => alu_b_in,
        ctrl => (OTHERS => '0'),
        c => cOut,
        z => zOut
    );

END arch;