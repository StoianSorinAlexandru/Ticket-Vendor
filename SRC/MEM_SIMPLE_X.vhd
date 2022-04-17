library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;	 

entity MEM_SIMPLE is
	
	port(									
		SEL:in STD_LOGIC;
		X: in STD_LOGIC_VECTOR(7 downto 0);	  
		W: inout STD_LOGIC_VECTOR(7 downto 0)		
	);
	
end entity;		   

architecture MIXT of MEM_SIMPLE is
begin
	
process	(SEL, X)
begin
	if(SEL='0')	then
		W<=W;
	elsif SEL='1' then
		W<=X;		  
	else
		W<="XXXXXXXX";
	end if;
end process;

end architecture;