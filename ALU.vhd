library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port(
        aluA, aluB: in std_logic_vector(15 downto 0);
        ctrl: in std_logic_vector(15 downto 0);
        c, z: in std_logic;
        aluC: out std_logic_vector(15 downto 0);
        cOut, zOut: out std_logic
    );
end entity alu;

architecture aluArc of alu is
signal a : std_logic_vector(16 downto 0);
begin
		
    process (aluA, aluB, ctrl, c, z)
    begin
        case ctrl is
            when "0000000000000000" =>  -- ADD
				aluC <= std_logic_vector(unsigned(aluA) + unsigned(aluB));
               a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
					cOut <= a(16);
					
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
            when "0000000000000001" =>  -- ADC
                if c = '1' then
                    aluC <= std_logic_vector(unsigned(aluA) + unsigned(aluB));
                     a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
					cOut <= a(16);
					
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
                else
                    aluC <= aluA;
 a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
					cOut <= a(16);
					
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;                end if;
            when "0000000000000010" =>  -- ADZ
                if z = '1' then
                    aluC <= std_logic_vector(unsigned(aluA) + unsigned(aluB));
                    a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
					cOut <= a(16);
					
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
                else
                    aluC <= aluA;
                    a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
					cOut <= a(16);
					
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
                end if;
            when "0000000000000100" =>  -- AWC
                aluC <= std_logic_vector(unsigned(aluA) + unsigned(aluB) + (c => c));
                a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
					cOut <= a(16);
					
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
            when "0000000000000101" =>  -- ACA
                aluC <= std_logic_vector(unsigned(aluA) + not(unsigned(aluA)));
                 a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
					cOut <= a(16);
					
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
            when "0000000000000110" =>  -- ACC
                if c = '1' then
                    aluC <= std_logic_vector(unsigned(aluA) + not(unsigned(aluB)));
                     a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
					cOut <= a(16);
					
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
                else
                    aluC <= aluA;
                    cOut <= c;
                    zOut <= z;
                end if;
            when "0000000000000111" =>  -- ACZ
                if z = '1' then
                    aluC <= std_logic_vector(unsigned(aluA) + not(unsigned(aluB)));
                     a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
					cOut <= a(16);
					
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
                else
                    aluC <= aluA;
                    cOut <= c;
                    zOut <= z;
                end if;
            when "0000000000001000" =>  -- ACW
                aluC <= std_logic_vector(unsigned(aluA) + not(unsigned(aluB)) + (c => c));
                a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
					cOut <= a(16);
					
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
				when "0000000000001001" =>
					 aluC <= std_logic_vector(unsigned(aluA) + signed(resize(signed(ctrl(5 downto 0)), 16)));
                 a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
					cOut <= a(16);
					
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
            when "0000000000001010" =>  -- NDU
                aluC <= not (aluA and aluB);
              
					
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
            when "0000000000001011" =>  -- NDC
                if c = '1' then
                    aluC <= not (aluA and aluB);
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
                else
                    aluC <= aluA;
                    zOut <= z;
                end if;
            when "0000000000001100" =>  -- NDZ
                if z = '1' then
                    aluC <= not (aluA and aluB);
              
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
                else
                    aluC <= aluA;
                    zOut <= z;
                end if;
            when "0000000000001101" =>  -- NCU
                aluC <= not (aluA and not aluB);
             
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
            when "0000000000001110" =>  -- NCC
                if c = '1' then
                    aluC <= not (aluA and not aluB);
               
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
                else
                    aluC <= aluA;
                    zOut <= z;
                end if;
            when "0000000000001111" =>  -- NCZ
                if z = '1' then
                    aluC <= not (aluA and not aluB);
					
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
                else
                    aluC <= aluA;
                    zOut <= z;
                end if;
            when "0000000000010000" =>  -- LLI
                aluC <= aluA(15 downto 9) & ctrl(5 downto 0) & (others => '0');
            
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
            when "0000000000010001" =>  -- LW
                aluC <= std_logic_vector(unsigned(aluA) + signed(resize(signed(ctrl(5 downto 0)), 16)));
          
					
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
				 when "0000000000010010" =>  -- SW
                aluC <= aluA;
            when "0000000000010011" =>  -- LM
                aluC <= aluA;
            when "0000000000010100" =>  -- SM
                aluC <= aluA;
            when "0000000000010101" =>  -- BEQ
                if aluA = aluB then
                    aluC <= std_logic_vector(unsigned(aluA) + signed(resize(signed(ctrl(5 downto 0)), 16)));
                else
                    aluC <= aluA;
                end if;
            when "0000000000010110" =>  -- BLT
                if signed(aluA) < signed(aluB) then
                    aluC <= std_logic_vector(unsigned(aluA) + signed(resize(signed(ctrl(5 downto 0)), 16)));
                else
                    aluC <= aluA;
                end if;
            when "0000000000010111" =>  -- BLE
                if signed(aluA) <= signed(aluB) then
                    aluC <= std_logic_vector(unsigned(aluA) + signed(resize(signed(ctrl(5 downto 0)), 16)));
                else
                    aluC <= aluA;
                end if;
            when "0000000000011000" =>  -- JAL
                aluC <= std_logic_vector(unsigned(aluA) + signed(resize(signed(ctrl(5 downto 0)), 16)));
				 when "0000000000010010" =>  -- JLR
                aluC <= std_logic_vector(unsigned(aluB) + 2);
           
					
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
            when "0000000000010011" =>  -- JRI
                aluC <= std_logic_vector(unsigned(aluA) + signed(resize(signed(ctrl(5 downto 0)), 16)) * 2);
             
					
                if aluC = (others => '0') then
					 zOut <= '1';
					 else 
					 zOut <= '0';
					 end if;
            when others =>
                aluC <= (others => '0');
                cOut <= '0';
                zOut <= '0';
					 
					 
        end case;
    end process;
end architecture aluArc;
