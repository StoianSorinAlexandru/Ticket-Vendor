library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;

entity C13_FINAL is
	
	port(		 
		X  : in STD_LOGIC_VECTOR(11 downto 0);
		Y  : out STD_LOGIC_VECTOR(11 downto 0)
	);
	
end C13_FINAL;

architecture MIXT of C13_FINAL is
begin

	Y(0)<=X(11);
	Y(1)<=X(10);
	Y(2)<=X(9);
	Y(3)<=X(8);
	Y(4)<=X(7);
	Y(5)<=X(6);
	Y(6)<=X(5);
	Y(7)<=X(4);
	Y(8)<=X(3);
	Y(9)<=X(2);
	Y(10)<=X(1);
	Y(11)<=X(0);

end architecture;