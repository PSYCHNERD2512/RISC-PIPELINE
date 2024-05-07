LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY alu IS
    PORT (
        aluA, aluB : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        ctrl : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        c, z : IN STD_LOGIC;
        aluC : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        cOut, zOut : OUT STD_LOGIC
    );
END ENTITY alu;

ARCHITECTURE aluArc OF alu IS
    SIGNAL a : STD_LOGIC_VECTOR(16 DOWNTO 0);
BEGIN

    PROCESS (aluA, aluB, ctrl, c, z)
    BEGIN
        CASE ctrl IS
            WHEN "0000000000000000" => -- ADD
                aluC <= STD_LOGIC_VECTOR(unsigned(aluA) + unsigned(aluB));
                a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
                cOut <= a(16);

                IF aluC = (OTHERS => '0') THEN
                    zOut <= '1';
                ELSE
                    zOut <= '0';
                END IF;
            WHEN "0000000000000001" => -- ADC
                IF c = '1' THEN
                    aluC <= STD_LOGIC_VECTOR(unsigned(aluA) + unsigned(aluB));
                    a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
                    cOut <= a(16);

                    IF aluC = (OTHERS => '0') THEN
                        zOut <= '1';
                    ELSE
                        zOut <= '0';
                    END IF;
                ELSE
                    aluC <= aluA;
                    a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
                    cOut <= a(16);

                    IF aluC = (OTHERS => '0') THEN
                        zOut <= '1';
                    ELSE
                        zOut <= '0';
                    END IF;
                END IF;
            WHEN "0000000000000010" => -- ADZ
                IF z = '1' THEN
                    aluC <= STD_LOGIC_VECTOR(unsigned(aluA) + unsigned(aluB));
                    a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
                    cOut <= a(16);

                    IF aluC = (OTHERS => '0') THEN
                        zOut <= '1';
                    ELSE
                        zOut <= '0';
                    END IF;
                ELSE
                    aluC <= aluA;
                    a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
                    cOut <= a(16);

                    IF aluC = (OTHERS => '0') THEN
                        zOut <= '1';
                    ELSE
                        zOut <= '0';
                    END IF;
                END IF;
            WHEN "0000000000000100" => -- AWC
                aluC <= STD_LOGIC_VECTOR(unsigned(aluA) + unsigned(aluB) + (c => c));
                a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
                cOut <= a(16);

                IF aluC = (OTHERS => '0') THEN
                    zOut <= '1';
                ELSE
                    zOut <= '0';
                END IF;
            WHEN "0000000000000101" => -- ACA
                aluC <= STD_LOGIC_VECTOR(unsigned(aluA) + NOT(unsigned(aluA)));
                a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
                cOut <= a(16);

                IF aluC = (OTHERS => '0') THEN
                    zOut <= '1';
                ELSE
                    zOut <= '0';
                END IF;
            WHEN "0000000000000110" => -- ACC
                IF c = '1' THEN
                    aluC <= STD_LOGIC_VECTOR(unsigned(aluA) + NOT(unsigned(aluB)));
                    a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
                    cOut <= a(16);

                    IF aluC = (OTHERS => '0') THEN
                        zOut <= '1';
                    ELSE
                        zOut <= '0';
                    END IF;
                ELSE
                    aluC <= aluA;
                    cOut <= c;
                    zOut <= z;
                END IF;
            WHEN "0000000000000111" => -- ACZ
                IF z = '1' THEN
                    aluC <= STD_LOGIC_VECTOR(unsigned(aluA) + NOT(unsigned(aluB)));
                    a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
                    cOut <= a(16);

                    IF aluC = (OTHERS => '0') THEN
                        zOut <= '1';
                    ELSE
                        zOut <= '0';
                    END IF;
                ELSE
                    aluC <= aluA;
                    cOut <= c;
                    zOut <= z;
                END IF;
            WHEN "0000000000001000" => -- ACW
                aluC <= STD_LOGIC_VECTOR(unsigned(aluA) + NOT(unsigned(aluB)) + (c => c));
                a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
                cOut <= a(16);

                IF aluC = (OTHERS => '0') THEN
                    zOut <= '1';
                ELSE
                    zOut <= '0';
                END IF;
            WHEN "0000000000001001" =>
                aluC <= STD_LOGIC_VECTOR(unsigned(aluA) + signed(resize(signed(ctrl(5 DOWNTO 0)), 16)));
                a <= (('0' & unsigned(aluA)) + ('0' & unsigned(aluB)));
                cOut <= a(16);

                IF aluC = (OTHERS => '0') THEN
                    zOut <= '1';
                ELSE
                    zOut <= '0';
                END IF;
            WHEN "0000000000001010" => -- NDU
                aluC <= NOT (aluA AND aluB);
                IF aluC = (OTHERS => '0') THEN
                    zOut <= '1';
                ELSE
                    zOut <= '0';
                END IF;
            WHEN "0000000000001011" => -- NDC
                IF c = '1' THEN
                    aluC <= NOT (aluA AND aluB);
                    IF aluC = (OTHERS => '0') THEN
                        zOut <= '1';
                    ELSE
                        zOut <= '0';
                    END IF;
                ELSE
                    aluC <= aluA;
                    zOut <= z;
                END IF;
            WHEN "0000000000001100" => -- NDZ
                IF z = '1' THEN
                    aluC <= NOT (aluA AND aluB);

                    IF aluC = (OTHERS => '0') THEN
                        zOut <= '1';
                    ELSE
                        zOut <= '0';
                    END IF;
                ELSE
                    aluC <= aluA;
                    zOut <= z;
                END IF;
            WHEN "0000000000001101" => -- NCU
                aluC <= NOT (aluA AND NOT aluB);

                IF aluC = (OTHERS => '0') THEN
                    zOut <= '1';
                ELSE
                    zOut <= '0';
                END IF;
            WHEN "0000000000001110" => -- NCC
                IF c = '1' THEN
                    aluC <= NOT (aluA AND NOT aluB);

                    IF aluC = (OTHERS => '0') THEN
                        zOut <= '1';
                    ELSE
                        zOut <= '0';
                    END IF;
                ELSE
                    aluC <= aluA;
                    zOut <= z;
                END IF;
            WHEN "0000000000001111" => -- NCZ
                IF z = '1' THEN
                    aluC <= NOT (aluA AND NOT aluB);

                    IF aluC = (OTHERS => '0') THEN
                        zOut <= '1';
                    ELSE
                        zOut <= '0';
                    END IF;
                ELSE
                    aluC <= aluA;
                    zOut <= z;
                END IF;
            WHEN "0000000000010000" => -- LLI
                aluC <= aluA(15 DOWNTO 9) & ctrl(5 DOWNTO 0) & (OTHERS => '0');

                IF aluC = (OTHERS => '0') THEN
                    zOut <= '1';
                ELSE
                    zOut <= '0';
                END IF;
            WHEN "0000000000010001" => -- LW
                aluC <= STD_LOGIC_VECTOR(unsigned(aluA) + signed(resize(signed(ctrl(5 DOWNTO 0)), 16)));
                IF aluC = (OTHERS => '0') THEN
                    zOut <= '1';
                ELSE
                    zOut <= '0';
                END IF;
            WHEN "0000000000010010" => -- SW
                aluC <= aluA;
            WHEN "0000000000010011" => -- LM
                aluC <= aluA;
            WHEN "0000000000010100" => -- SM
                aluC <= aluA;
            WHEN "0000000000010101" => -- BEQ
                IF aluA = aluB THEN
                    aluC <= STD_LOGIC_VECTOR(unsigned(aluA) + signed(resize(signed(ctrl(5 DOWNTO 0)), 16)));
                ELSE
                    aluC <= aluA;
                END IF;
            WHEN "0000000000010110" => -- BLT
                IF signed(aluA) < signed(aluB) THEN
                    aluC <= STD_LOGIC_VECTOR(unsigned(aluA) + signed(resize(signed(ctrl(5 DOWNTO 0)), 16)));
                ELSE
                    aluC <= aluA;
                END IF;
            WHEN "0000000000010111" => -- BLE
                IF signed(aluA) <= signed(aluB) THEN
                    aluC <= STD_LOGIC_VECTOR(unsigned(aluA) + signed(resize(signed(ctrl(5 DOWNTO 0)), 16)));
                ELSE
                    aluC <= aluA;
                END IF;
            WHEN "0000000000011000" => -- JAL
                aluC <= STD_LOGIC_VECTOR(unsigned(aluA) + signed(resize(signed(ctrl(5 DOWNTO 0)), 16)));
            WHEN "0000000000010010" => -- JLR
                aluC <= STD_LOGIC_VECTOR(unsigned(aluB) + 2);
                IF aluC = (OTHERS => '0') THEN
                    zOut <= '1';
                ELSE
                    zOut <= '0';
                END IF;
            WHEN "0000000000010011" => -- JRI
                aluC <= STD_LOGIC_VECTOR(unsigned(aluA) + signed(resize(signed(ctrl(5 DOWNTO 0)), 16)) * 2);
                IF aluC = (OTHERS => '0') THEN
                    zOut <= '1';
                ELSE
                    zOut <= '0';
                END IF;
            WHEN OTHERS =>
                aluC <= (OTHERS => '0');
                cOut <= '0';
                zOut <= '0';
        END CASE;
    END PROCESS;
END ARCHITECTURE aluArc;