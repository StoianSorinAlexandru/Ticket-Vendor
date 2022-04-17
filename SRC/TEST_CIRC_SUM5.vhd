library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;	
use ieee.std_logic_UNSIGNED.all;

entity TEST_CIRC_SUM5 is
	
	port
	(
	
		A1, A2, A3, A4, A5: in STD_LOGIC_VECTOR(7 downto 0);
	
		SUM: out STD_LOGIC_VECTOR(7 downto 0)
	
	);
	
end entity;

architecture MIXT of TEST_CIRC_SUM5 is

signal AUX1, AUX2, AUX3, AUX4, AUX5:STD_LOGIC_VECTOR(7 downto 0);																   												   

begin
	
	AUX1<="00000000";
	                     
 	AUX2<=AUX1+A1;
	AUX3<=AUX2+A2;
	AUX4<=AUX3+A3;
	AUX5<=AUX4+A4;
							  			  
	SUM<=AUX5+A5;

end architecture;
