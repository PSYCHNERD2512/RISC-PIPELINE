library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.all;

entity pipeline_cpu is
    port (
        i: in std_logic_vector(31 downto 0);
        clk: in std_logic
    );
end entity pipeline_cpu;


architecture arch of pipeline_cpu is

    component alu is
        port (
            aluA, aluB: in std_logic_vector(15 downto 0);
            ctrl: in std_logic_vector(15 downto 0);
            c, z: in std_logic;
            aluC: out std_logic_vector(15 downto 0);
            cOut, zOut: out std_logic
        );
    end component alu;

    component rf is
        port (
            A1, A2, A3: in std_logic_vector(2 downto 0);
            D1, D2: out std_logic_vector(15 downto 0);
            D3: in std_logic_vector(15 downto 0);
            clk, rf_write: in std_logic
        );
    end component rf;

    signal D1_out, D2_out, aluC_out: std_logic_vector(15 downto 0);
    signal cOut, zOut: std_logic;

begin

 
    RF_inst: rf port map (
        A1 => (others => '0'),  
        A2 => (others => '0'),  
        A3 => (others => '0'),  
        D1 => D1_out,
        D2 => D2_out,
        D3 => (others => '0'),  
        clk => clk,            
        rf_write => '0'         
    );


    ALU_inst: alu port map (
        aluA => D1_out,  
        aluB => D2_out,  
        ctrl => (others => '0'),  
        c => cOut,  
        z => zOut 
    );

end arch;
