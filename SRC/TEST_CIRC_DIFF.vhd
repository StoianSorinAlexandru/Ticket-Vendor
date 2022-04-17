library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;	 

entity CIRC_DIFF is
	
	port(
		X1: in STD_LOGIC_VECTOR(7 downto 0);
		Y1: in STD_LOGIC_VECTOR(7 downto 0);
		W1: out STD_LOGIC_VECTOR(7 downto 0)		
	);
	
end entity;		 

architecture MXT of CIRC_DIFF is
begin		
	process(X1, Y1)
	begin
		
		if(X1>Y1) then
			W1<=X1-Y1;	  
		elsif X1=Y1 then
			W1<="00000000";
		else
		  	W1<="XXXXXXXX";	
		end if;
	end process;
	
end architecture;