library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;

entity C7_FINAL is
	
	port(  	 
		INC, DEC: in STD_LOGIC;		  
		EN: in STD_LOGIC_VECTOR(1 downto 0);	   
		
		Q:inout STD_LOGIC_VECTOR(7 downto 0)
	);
end C7_FINAL;				  

architecture MIXT of C7_FINAL is

	component CIRC_MAC_FINAL 
	
	port(
		INC, DEC: in STD_LOGIC; 	 
		EN: in STD_LOGIC_VECTOR(1 downto 0); 
		PL: in STD_LOGIC_VECTOR(7 downto 0);  
		Q: inout STD_LOGIC_VECTOR(7 downto 0)
	);
	
		
	end component;
														   	   
begin
	 	   
	C: CIRC_MAC_FINAL port map(INC, DEC, EN, "00000000", Q);
													 
end architecture;