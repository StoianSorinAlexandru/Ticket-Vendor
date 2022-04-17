library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;	 

entity TEST_CIRC_DIFF is
	
	port(
		X2: in STD_LOGIC_VECTOR(7 downto 0);
		Y2: in STD_LOGIC_VECTOR(7 downto 0);
		W2: out STD_LOGIC_VECTOR(7 downto 0)		
	);
	
end entity;		 

architecture MXT of TEST_CIRC_DIFF is
begin
	W2<=X2-Y2;

end architecture;