--TEST_CIRC_MULTIPLIER

library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;	 

entity TEST_CIRC_MULTIPLIER is
	
	port(
	
		X1, X2: in STD_LOGIC_VECTOR(7 downto 0);
	
		W: out STD_LOGIC_VECTOR(7 downto 0)
		
	);
	
end entity;	   							  

architecture MIXT of TEST_CIRC_MULTIPLIER is

signal AUX1, AUX2: signed(7 downto 0); 
signal AUX3: signed(15 downto 0);

begin								  
	
	AUX1<=signed(X1);
	AUX2<=signed(X2);
	AUX3<=AUX1*AUX2;
	
	W<=STD_LOGIC_VECTOR(AUX3(7 downto 0));

end architecture;