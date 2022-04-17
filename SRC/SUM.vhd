library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;

entity SUM1 is
	
	port(
		X1: in STD_LOGIC_VECTOR(15 downto 0);
		Y1: in STD_LOGIC_VECTOR(11 downto 0);
		W1: out STD_LOGIC_VECTOR(11 downto 0)		
	);
	
end entity;		 
									   
architecture COMP of SUM1 is		
	signal AUX: STD_LOGIC_VECTOR(15 downto 0);
	begin
	AUX<=X1+Y1;
	W1<=AUX(11 downto 0);
	
end architecture;