library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity STD_M is
	port(
		A	: in STD_LOGIC_VECTOR (7 downto 0);
		B	: in STD_LOGIC_VECTOR (7 downto 0);
		REZ	: out STD_LOGIC_VECTOR (15 downto 0)
	);

end entity;

architecture SIGNED_TO_STD_LOGIC of STD_M is	   

signal A1: SIGNED (7 downto 0);	
signal B1: SIGNED (7 downto 0);
signal REZ1: SIGNED (15 downto 0);

begin				
	
	A1 <= SIGNED(A); 
	B1 <= SIGNED(B);
	
	REZ1 <= A1 * B1;
	
	REZ <= STD_LOGIC_VECTOR(REZ1);
	
end SIGNED_TO_STD_LOGIC;
