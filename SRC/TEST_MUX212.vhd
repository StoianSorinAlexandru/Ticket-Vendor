									  library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;	 

entity MUX212 is
	
	port(									
		SEL:in STD_LOGIC;
		X: in STD_LOGIC_VECTOR(7 downto 0);
		Y: in STD_LOGIC_VECTOR(7 downto 0);
		W: out STD_LOGIC_VECTOR(7 downto 0)		
	);
	
end entity;	

architecture MIXT of MUX212 is	

begin		
	process(SEL, X, Y)
	begin
		if(SEL='0')then
			W<=X;	  
		elsif SEL='1' then 
			W<=Y;
		else
			W<="00000000";
		end if;
	end process;
end architecture;