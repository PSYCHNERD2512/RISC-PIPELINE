library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

type memory is array(1023 downto 0) of std_logic_vector(15 downto 0);	
signal instruction_mem : memory := (
	0 => "1111010000001110",
	3 => "0001011101001000",
	30 => "0001110111010000",
	31 => "1100111001100110",
	235 => "1001001010001110",
	others=>("1110000000000000")
	);
signal data_mem : memory := (
	0 => "1111010000001110",
	3 => "0001011101001000",
	30 => "0001110111010000",
	31 => "1100111001100110",
	235 => "1001001010001110",
	others=>("1110000000000000")
	);